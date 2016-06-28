class AddTopicToCategory < ActiveRecord::Migration[5.0]
  def change
    add_reference :categories, :topic, foreign_key: true
  end
end
