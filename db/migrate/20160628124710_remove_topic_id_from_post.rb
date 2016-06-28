class RemoveTopicIdFromPost < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :topic_id, :integer
  end
end
