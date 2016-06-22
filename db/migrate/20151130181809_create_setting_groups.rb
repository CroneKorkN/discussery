class CreateSettingGroups < ActiveRecord::Migration
  def change
    create_table :setting_groups do |t|
      t.string :name
      t.references :setting_group, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :setting_groups, :name
  end
end
