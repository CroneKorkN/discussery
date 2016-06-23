class Group < ActiveRecord::Base
  has_many :user_groups
  has_many :users, through: :user_groups
  has_many :group_groups
  has_many :member_groups, through: :group_groups
  has_many :group_roles
  has_many :roles, through: :group_roles
end
