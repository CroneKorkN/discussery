class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_one :category, through: :topic
end
