class AddParentTypeToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :parent_type, :string
    add_index :categories, :parent_type
  end
end
