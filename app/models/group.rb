class Group < ActiveRecord::Base
  has_many :user_groups
  has_many :users,
    through: :user_groups
    
  has_many :role_scopes
  has_many :roles,
    through: :role_scopes
  has_many :scoping_role_scopes,
    class_name: "RoleScope"
  has_many :scoping_roles,
    through: :scoping_role_scopes,
    source: :role
  
  has_many :group_groups
  has_many :groups,
    through: :group_groups
  has_many :member_groups,
    through: :group_groups
  
  has_many :group_memberships,
    class_name: "GroupGroup",
    foreign_key: :member_group_id
  has_many :memberships,
    through: :group_memberships,
    source: :group
    
  has_many :categories,
    as: :parent
  has_one :topic,
    as: :topicable
  
  after_create do
    unless self.background
      create_group_category
      create_group_topic
      admin_group = create_admin_group
      make_creator_admin admin_group
    end
  end
  
  private
  
  def create_group_category
    self.categories.create name: "group_#{self.id}_category"
  end
  
  def create_group_topic
    self.create_topic name: "group_#{self.id}_topic"
  end
      
  def create_admin_group
    Group.create name: "group_#{self.id}_admins", background: true
  end
  
  def make_creator_admin group_admin_group
    group_admin_group.role_scopes.create role: Role.find_by(name: "admin"), scopable: self
  end
end
