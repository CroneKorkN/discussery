class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.references :user, index: true, foreign_key: true
      t.references :role, index: true, foreign_key: true
      t.string :scopable_type
      t.integer :scopable_id

      t.timestamps null: false
    end
    add_index :user_roles, :scopable_type
    add_index :user_roles, :scopable_id
  end
end
