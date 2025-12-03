class MensagensController < ApplicationController
  before_action :set_sala, only: %i[create edit]
  before_action :set_mensagem, only: %i[edit update destroy]
  before_action :ensure_sala_member!, only: %i[create edit]
  before_action :authorize_mensagem!, only: %i[edit update destroy]

  def create
    @mensagem = @sala.mensagens.new mensagem_params
    @mensagem.usuario = current_usuario

    respond_to do |format|
      if @mensagem.save
        format.turbo_stream
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @mensagem.update mensagem_params
        format.turbo_stream
      end
    end
  end

  def destroy
    @mensagem.destroy

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_sala
    @sala = Sala.find(params[:sala_id])
  end

  def set_mensagem
    @mensagem = Mensagem.find(params[:id])
  end

  def ensure_sala_member!
    return if current_usuario.usuarios_salas.exists?(sala_id: @sala.id)

    redirect_to salas_path, alert: 'Você não participa desta sala.'
  end

  def authorize_mensagem!
    @sala ||= @mensagem.sala
    vinculo = current_usuario.usuarios_salas.find_by(sala_id: @sala.id)
    return if vinculo&.admin? || @mensagem.usuario_id == current_usuario.id

    redirect_to sala_path(@sala), alert: 'Você não tem permissão para essa ação.'
  end

  def mensagem_params
    params.require(:mensagem).permit(:conteudo)
  end
end
