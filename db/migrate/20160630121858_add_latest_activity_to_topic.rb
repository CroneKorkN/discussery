class AddLatestActivityToTopic < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :latest_activity_at, :datetime
  end
end
