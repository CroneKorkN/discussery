class Group < ActiveRecord::Base    
  has_many :roles
  has_many :role_types,
    through: :roles
    
  has_many :scoping_roles,
    class_name: "Role"
  has_many :scoping_role_types,
    through: :scoping_roles,
    source: :role_type
  
  # memberships
  has_many :is_member_of,
    class_name: "Membership",
    as: :member
  has_many :memberships,
     through: :is_member_of,
     source: :group
  
  # members
  has_many :has_members,
    class_name: "Membership",
    foreign_key: :group_id
  has_many :member_users,
    through: :has_members,
    source: :member,
    source_type: "User"
  has_many :member_groups,
    through: :has_members,
    source: :member,
    source_type: "Group"
  def members
    member_users + member_groups
  end
  
  has_one :category,
    as: :parent
  has_one :topic,
    through: :category,
    source: :root_topic
  has_many :posts,
    through: :topic
  
  after_create do
    unless self.background
      category = self.create_category name: "group_#{self.id}_category"
      
      # ERROR: root-topic-id muss aus irgendeinem Grund manuell gesetzt werden. Relation falsch?
      category.update root_topic: self.category.create_root_topic(name: "group_#{self.id}_topic", user_id: Setting[:system_user_id], category: category)
      
      make_creator_admin create_admin_group
    end
  end
  
  private
  
  def create_group_category
    self.create_category name: "group_#{self.id}_category"
  end
  
  def create_group_topic
    self.create_topic name: "group_#{self.id}_category"
  end
      
  def create_admin_group
    Group.create name: "group_#{self.id}_admins", background: true
  end
  
  def make_creator_admin group_admin_group
    group_admin_group.roles.create role_type: RoleType.find_by(name: "admin"), permittable: self
  end
end
