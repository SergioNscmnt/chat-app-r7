class UsuarioSala < ApplicationRecord
  self.table_name = "usuarios_salas"

  belongs_to :usuario
  belongs_to :sala

  enum papel: { membro: 'member', admin: 'admin' }

  validates :papel, presence: true
  validates :categoria, length: { maximum: 50 }, allow_blank: true

  def display_category
    categoria.presence || 'Sem categoria'
  end
end
