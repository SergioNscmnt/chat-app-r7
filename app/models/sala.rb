class Sala < ApplicationRecord
  self.table_name = "salas"

  validates :nome, presence: true
  has_many :usuarios_salas, class_name: "UsuarioSala", foreign_key: :sala_id, inverse_of: :sala
  has_many :usuarios, through: :usuarios_salas
  has_many :mensagens, class_name: "Mensagem", foreign_key: :sala_id

  def vinculo_para(usuario)
    usuarios_salas.find_by(usuario: usuario)
  end

  def admin?(usuario)
    vinculo_para(usuario)&.admin?
  end
end
