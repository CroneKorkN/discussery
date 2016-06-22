class RemoveScopableFromUserRoles < ActiveRecord::Migration
  def change
    remove_column :user_roles, :scopable_type, :string
    remove_column :user_roles, :scopable_id, :string
  end
end
