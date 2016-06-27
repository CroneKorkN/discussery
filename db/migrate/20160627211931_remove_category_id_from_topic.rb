class RemoveCategoryIdFromTopic < ActiveRecord::Migration[5.0]
  def change
    remove_column :topics, :category_id, :string
  end
end
