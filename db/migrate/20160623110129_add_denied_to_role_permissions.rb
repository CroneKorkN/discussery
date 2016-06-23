class AddDeniedToRolePermissions < ActiveRecord::Migration[5.0]
  def change
    add_column :role_permissions, :denied, :boolean, null: false, default: false
    remove_column :role_permissions, :grant
  end
end
