class CreatePermissionTypes < ActiveRecord::Migration
  def change
    create_table :permission_types do |t|
      t.string :controller
      t.string :action

      t.timestamps null: false
    end
    add_index :permission_types, :controller
    add_index :permission_types, :action
  end
end
