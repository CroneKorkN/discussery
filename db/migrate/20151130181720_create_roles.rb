class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, index: true, null: false
    end
  end
end
