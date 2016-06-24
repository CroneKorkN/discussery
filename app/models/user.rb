class User < ActiveRecord::Base
  # content
  has_many :topics
  has_many :posts
  has_many :topics,
           through: :posts
  has_many :media
  has_many :attachments
  belongs_to :medium, optional: true
  
  # else
  has_many :user_groups
  has_many :groups,
    through: :user_groups
  has_many :user_roles
  has_many :roles, through: :user_roles
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
end
