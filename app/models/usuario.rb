class Usuario < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :usuarios_salas, class_name: "UsuarioSala", foreign_key: :usuario_id, inverse_of: :usuario
  has_many :salas, through: :usuarios_salas
  has_many :mensagens, class_name: "Mensagem", foreign_key: :usuario_id

  def vinculo_para(sala)
    usuarios_salas.find_by(sala: sala)
  end

  def admin_para?(sala)
    vinculo_para(sala)&.admin?
  end
end
