class AddDeniedToPermissions < ActiveRecord::Migration[5.0]
  def change
    add_column :permissions, :denied, :boolean, null: false, default: false
    remove_column :permissions, :grant
  end
end
