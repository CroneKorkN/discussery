class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, index: true, null: false
      t.string :mail, index: true, null: false
      t.string :password
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
