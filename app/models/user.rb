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
  has_many :memberships,
    through: :user_groups,
    source: :group
    
  belongs_to :medium, optional: true

  #alias_attribute :avatar, :medium
  def avatar
    medium || Medium.find(Setting["avatar_placeholder_medium_id"])
  end

  serialize :acl_cache

  has_secure_password validations: false

  def acl
    @acl ||= ACL.new(self)
  end

  def categories
    Category.where("id IN(?)", acl.visible_categories)
  end
  
  def groups
    @groups = Recursion.collect_all memberships, :groups
    
    
    unless @all_groups
      @all_group_ids = []
      memberships.each do |group|
        collect_group_ids group
      end
      @all_groups = Group.where "ID IN(?)", @all_group_ids
    end
    return @all_groups
  end
  
private
  
  def collect_group_ids group
    @all_group_ids << group
    group.memberships.each do |group|
      collect_group_ids group
    end
  end
end
