class AddParentIdToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :parent_id, :integer, default: 0
    add_index :categories, :parent_id
  end
end
