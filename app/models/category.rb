class Category < ActiveRecord::Base
  has_many :categories,
    as: :parent
  has_many :topics
  belongs_to :root_topic,
    foreign_key: :topic_id,
    optional: true,
    class_name: "Topic"
  has_many :posts,
    through: :topic
  belongs_to :parent,
    polymorphic: true,
    optional: true
end