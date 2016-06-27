class AddTopicableToTopic < ActiveRecord::Migration[5.0]
  def change
    add_reference :topics, :topicable, polymorphic: true, index: true
  end
end