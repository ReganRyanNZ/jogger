class AddRoleToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :role, :int, default: 0, null: false
  end
end
