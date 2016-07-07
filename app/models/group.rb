class Group < ApplicationRecord 
  belongs_to :creator,
    class_name: "User",
    optional: true
    
  has_many :roles,
    as: :permittable
  has_many :role_types,
    through: :roles
    
  has_many :scoping_roles,
    class_name: "Role"
  has_many :scoping_role_types,
    through: :scoping_roles,
    source: :role_type
  
  # memberships
  has_many :memberships,
    as: :member
  has_many :membership_groups,
    through: :memberships,
    source: :group
    
  # members
  has_many :members,
    class_name: "Membership",
    foreign_key: :group_id
  has_many :member_users,
    through: :members,
    source: :member,
    source_type: "User"
  has_many :member_groups,
    through: :members,
    source: :member,
    source_type: "Group"
  
  has_one :category,
    as: :parent
  has_one :topic,
    through: :category,
    source: :root_topic
  has_many :posts,
    through: :topic
    
  has_many :subscriptions,
    as: :subscribable
    
  belongs_to :medium, optional: true
  def avatar
    medium || Medium.find(Setting["avatar_placeholder_medium_id"])
  end
  
  after_create do
    # make creator member of the group
    members.create member: creator

    unless self.background
      # create group-category
      category = self.create_category name: "group_#{self.id}_category"
      # ERROR: root-topic-id muss aus irgendeinem Grund manuell gesetzt werden. Relation falsch?
      category.update root_topic: self.category.create_root_topic(name: "group_#{self.id}_topic", user_id: Setting[:system_user_id], category: category)

      # create background-group to handle permissions
      admin_group = Group.create name: "group_#{self.id}_admins", background: true
      
      # give the background-group admin-permissions
      # todo: get role_type by setting
      admin_group.roles.create role_type: RoleType.find_by(name: "admin"), protectable: self
      
      # make creator member of group admins group      
      admin_group.members.create member: creator
    end
  end

  def private_chat?
    true if name =~ /^PRIVATE_CHAT/
  end
  
  def icon
    private_chat? ? :private_chat : :group
  end
  
  private
      
  def create_admin_group
    Group.create name: "group_#{self.id}_admins", background: true
  end
  
  def make_creator_admin admin_group
  end
end
