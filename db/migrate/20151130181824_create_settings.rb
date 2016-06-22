class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :key
      t.text :value
      t.string :type
      t.string :name
      t.text :description
      t.references :setting_group, index: true, foreign_key: true
      t.integer :order

      t.timestamps null: false
    end
    add_index :settings, :key
    add_index :settings, :name
    add_index :settings, :order
  end
end
