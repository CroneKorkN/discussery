class User < ActiveRecord::Base
  has_many :topics
  has_many :posts
  has_many :topics,
           through: :posts
  has_many :media
  has_many :attachments
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :user_groups
  has_many :groups, through: :user_groups
  belongs_to :medium

  alias_attribute :avatar, :medium
  #def avatar
  #  medium || Medium.find(Setting["avatar_placeholder_medium_id"])
  #end

  serialize :acl_cache

  has_secure_password validations: false

  def acl
    @acl ||= ACL.new(self)
  end

  def categories
    Category.where("id IN(?)", acl.visible_categories)
  end
end
