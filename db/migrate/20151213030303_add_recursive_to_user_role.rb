class AddRecursiveToUserRole < ActiveRecord::Migration
  def change
    add_column :user_roles, :recursive, :boolean
    add_index :user_roles, :recursive
  end
end
