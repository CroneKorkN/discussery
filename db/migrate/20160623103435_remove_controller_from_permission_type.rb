class RemoveControllerFromPermissionType < ActiveRecord::Migration[5.0]
  def change
    remove_column :permission_types, :controller, :string
  end
end
