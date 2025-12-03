class RenomearModelosParaPortugues < ActiveRecord::Migration[7.0]
  def change
    rename_table :users, :usuarios
    rename_table :rooms, :salas
    rename_table :messages, :mensagens
    rename_table :user_rooms, :usuarios_salas

    rename_column :salas, :name, :nome

    rename_column :mensagens, :message, :conteudo
    rename_column :mensagens, :user_id, :usuario_id
    rename_column :mensagens, :room_id, :sala_id

    rename_column :usuarios_salas, :user_id, :usuario_id
    rename_column :usuarios_salas, :room_id, :sala_id
    rename_column :usuarios_salas, :category, :categoria
    rename_column :usuarios_salas, :role, :papel

    add_foreign_key :mensagens, :usuarios, column: :usuario_id
    add_foreign_key :mensagens, :salas, column: :sala_id
    add_foreign_key :usuarios_salas, :usuarios, column: :usuario_id
    add_foreign_key :usuarios_salas, :salas, column: :sala_id
  end
end
