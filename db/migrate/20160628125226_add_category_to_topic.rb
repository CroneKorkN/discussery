class AddCategoryToTopic < ActiveRecord::Migration[5.0]
  def change
    add_reference :topics, :category, foreign_key: true
  end
end
