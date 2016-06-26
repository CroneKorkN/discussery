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
end
