class User < ActiveRecord::Base
  # content
  has_many :topics
  has_many :posts
  has_many :answered_topics,
    through: :posts,
    source: :postable,
    source_type: "Topic"
  has_many :answered_groups,
    through: :posts,
    source: :postable,
    source_type: "Group"
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

  has_many :groups_created,
    foreign_key: :creator_id,
    class_name: "Group"

  has_many :memberships,
    as: :member
  has_many :groups,
    through: :memberships
  has_many :group_chats,
    through: :groups,
    source: :topic

  serialize :acl_cache
  
  
  has_secure_password validations: false
    
  def avatar
    medium || Medium.find(Setting["avatar_placeholder_medium_id"])
  end
  
  def activities
    (answered_topics + answered_groups).uniq
  end

  def may? action, object
    acl.allows? action, object
  end
  def visibile objects # :categories e.g.
    Object.const_get(objects.to_s.classify).where("id IN(?)", acl.visible(objects))
  end
  
  private
  
  def acl
    @acl ||= ACL.new(self)
  end
end
