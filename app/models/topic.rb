class Topic < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :posts,
    as: :postable
  has_one :root_of,
    class_name: :Category,
    foreign_key: :topic_id
  has_one :group,
    through: :root_of,
    source: :parent,
    source_type: "Group"
  has_many :subscriptions,
    as: :subscribable
    
  def container
    group || root_of || self
  end
  
  def icon 
    :topic
  end
end