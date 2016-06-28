class Category < ActiveRecord::Base
  has_many :categories,
    as: :parent
  has_many :topics
  has_many :posts,
    as: :postable
  belongs_to :parent,
    polymorphic: true,
    optional: true
end