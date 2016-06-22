class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :controller
      t.string :action

      t.timestamps null: false
    end
    add_index :permissions, :controller
    add_index :permissions, :action
  end
end
