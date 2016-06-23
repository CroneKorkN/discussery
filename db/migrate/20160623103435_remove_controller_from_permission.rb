class RemoveControllerFromPermission < ActiveRecord::Migration[5.0]
  def change
    remove_column :permissions, :controller, :string
  end
end
