class CreateGroupGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :group_groups do |t|
      t.references :group, foreign_key: true
      t.integer :member_group_id

      t.timestamps
    end
    add_index :group_groups, :member_group_id
  end
end
