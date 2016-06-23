class CreateGroupRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :group_roles do |t|
      t.references :group, foreign_key: true
      t.references :role, foreign_key: true
      t.references :category, foreign_key: true
      t.boolean :recursive, null: false, default: false

      t.timestamps
    end
  end
end
