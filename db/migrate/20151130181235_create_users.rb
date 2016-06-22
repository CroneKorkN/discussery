class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :mail
      t.string :password
      t.string :password_digest

      t.timestamps null: false
    end
    add_index :users, :name
    add_index :users, :mail
  end
end
