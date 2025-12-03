class Mensagem < ApplicationRecord
  self.table_name = "mensagens"

  belongs_to :usuario
  belongs_to :sala

  after_create_commit :broadcast_mensagens_criacao
  after_update_commit :broadcast_mensagens_atualizacao
  after_destroy_commit :broadcast_mensagens_remocao

  private

  def broadcast_mensagens_criacao
    broadcast_append_to('sala_mensagens_channel', partial: 'mensagens/mensagem', locals: {mensagem: self}, target: "sala_mensagens_div")
  end

  def broadcast_mensagens_atualizacao
    broadcast_replace_to('sala_mensagens_channel', partial: 'mensagens/mensagem', locals: {mensagem: self}, target: "mensagem_#{id}")
  end

  def broadcast_mensagens_remocao
    broadcast_remove_to('sala_mensagens_channel', target: "mensagem_#{id}")
  end
end
