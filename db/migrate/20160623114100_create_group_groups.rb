class CreateGroupGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :group_groups do |t|
      t.references :group, foreign_key: true
      t.integer :member_group_id, null: false, default: 0, index: true

      t.timestamps
    end
  end
end
