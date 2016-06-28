class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.references :role_type, index: true, foreign_key: true
      t.references :permission_type, index: true, foreign_key: true
      t.integer :grant

      t.timestamps null: false
    end
  end
end
