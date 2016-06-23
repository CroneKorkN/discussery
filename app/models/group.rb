class Group < ActiveRecord::Base
  has_many :user_groups
  has_many :users,
    through: :user_groups
  
  has_many :member_groups,
    through: :group_groups
  has_many :group_roles
  
  has_many :roles,
    through: :group_roles
  
  has_many :group_groups
  has_many :groups,
    through: :group_groups
  
  has_many :group_memberships,
    class_name: "GroupGroup",
    foreign_key: :member_group_id
  has_many :memberships,
    through: :group_memberships,
    source: :group
end
