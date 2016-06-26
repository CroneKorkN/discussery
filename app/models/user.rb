class User < ActiveRecord::Base
  # content
  has_many :topics

  has_many :posts
  has_many :answered_topics,
           through: :posts,
           source: :topic
  has_many :media
  has_many :attachments
  belongs_to :medium, optional: true
  
  # else
  has_many :contact_links,
    class_name: "Contact"
  has_many :contacts,
    through: :contact_links,
    class_name: "User",
    primary_key: :contact_id
  has_many :user_groups
  has_many :groups,
    through: :user_groups
  serialize :acl_cache
  
  has_secure_password validations: false
    
  def avatar
    medium || Medium.find(Setting["avatar_placeholder_medium_id"])
  end

  def acl
    @acl ||= ACL.new(self)
  end

  def categories
    Category.where("id IN(?)", acl.visible_categories)
  end
  
  def activities
    answered_topics.uniq
  end
end
