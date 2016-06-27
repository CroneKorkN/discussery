class Topic < ActiveRecord::Base
  belongs_to :topicable,
    polymorphic: true
  belongs_to :user,
    optional: true
  has_many :posts
end