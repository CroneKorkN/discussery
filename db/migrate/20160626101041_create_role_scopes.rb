class CreateRoleScopes < ActiveRecord::Migration[5.0]
  def change
    create_table :role_scopes do |t|
      t.references :group, foreign_key: true
      t.references :role, foreign_key: true
      t.references :scopable, polymorphic: true, index: true
      t.boolean :recursive, default: false, null: false
    end
  end
end
