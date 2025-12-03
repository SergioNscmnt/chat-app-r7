class AddRoleAndCategoryToUserRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :user_rooms, :role, :string, null: false, default: 'member'
    add_column :user_rooms, :category, :string
    add_index :user_rooms, :role
  end
end
