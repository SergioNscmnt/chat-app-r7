class SalasController < ApplicationController
  before_action :set_sala, only: %i[ show edit update destroy add_usuario update_vinculo remove_usuario ]
  before_action :require_sala_admin!, only: %i[ edit update destroy add_usuario update_vinculo remove_usuario ]
  before_action :ensure_sala_member!, only: %i[ show ]

  def index
    @salas = Sala.includes(:usuarios_salas)
  end

  def show
    @vinculos = @sala.usuarios_salas.includes(:usuario)
    @usuarios_disponiveis = Usuario.where.not(id: @sala.usuario_ids)
  end

  def new
    @sala = Sala.new
  end

  def edit
  end

  def create
    @sala = Sala.new(sala_params)

    respond_to do |format|
      if @sala.save
        UsuarioSala.create(sala: @sala, usuario: current_usuario, papel: :admin)
        format.turbo_stream { redirect_to sala_path(@sala) }
        format.html { redirect_to sala_path(@sala), notice: 'Sala criada com sucesso.' }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("sala_form", partial: 'salas/form', locals: { sala: @sala, title: 'Criar nova sala' }) }
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @sala.update(sala_params)
        vinculo = @sala.vinculo_para(current_usuario)
        format.turbo_stream { render turbo_stream: turbo_stream.replace("sala_#{@sala.id}", partial: 'shared/sala', locals: { sala: @sala, usuario_atual: current_usuario, vinculo_atual: vinculo }) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @sala.destroy

    respond_to do |format|
      format.html { redirect_to salas_url, notice: "Sala excluída com sucesso." }
    end
  end

  def add_usuario
    return render_painel_vinculos if params[:usuario_id].blank?

    vinculo = UsuarioSala.find_or_initialize_by(sala: @sala, usuario_id: params[:usuario_id])
    vinculo.papel = params[:papel] || 'membro'
    vinculo.categoria = params[:categoria]
    vinculo.save

    render_painel_vinculos
  end

  def update_vinculo
    return render_painel_vinculos if params[:usuario_id].blank?

    vinculo = @sala.usuarios_salas.find_by(usuario_id: params[:usuario_id])
    vinculo&.update(papel: params[:papel], categoria: params[:categoria])
    render_painel_vinculos
  end

  def remove_usuario
    return render_painel_vinculos if params[:usuario_id].blank?

    vinculo = @sala.usuarios_salas.find_by(usuario_id: params[:usuario_id])
    vinculo&.destroy
    render_painel_vinculos
  end

  private
    def set_sala
      @sala = Sala.find(params[:id])
    end

    def ensure_sala_member!
      return if @sala.usuarios.include?(current_usuario) || @sala.admin?(current_usuario)

      redirect_to salas_path, alert: 'Você precisa fazer parte desta sala.'
    end

    def require_sala_admin!
      return if action_name == 'show' && @sala.usuarios.include?(current_usuario)
      return if @sala.admin?(current_usuario)

      redirect_to salas_path, alert: 'Acesso restrito aos administradores da sala.'
    end

    def render_painel_vinculos
      @vinculos = @sala.usuarios_salas.includes(:usuario)
      @usuarios_disponiveis = Usuario.where.not(id: @sala.usuario_ids)

      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("sala_team_panel", partial: 'salas/membros', locals: { sala: @sala, vinculos: @vinculos, usuarios_disponiveis: @usuarios_disponiveis }) }
        format.html { redirect_to sala_path(@sala) }
      end
    end

    def sala_params
      params.require(:sala).permit(:nome)
    end
end
