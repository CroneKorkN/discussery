class Category < ActiveRecord::Base
  has_many :categories,
    as: :parent
  has_many :topics,
    as: :topicable
  belongs_to :parent, polymorphic: true, optional: true
end