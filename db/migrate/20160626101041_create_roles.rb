class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.references :group, foreign_key: true
      t.references :role_type, foreign_key: true
      t.references :protectable, polymorphic: true, index: true
      t.boolean :recursive, default: false, null: false
    end
  end
end
