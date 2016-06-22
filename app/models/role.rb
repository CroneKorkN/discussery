class Role < ActiveRecord::Base
  has_many :role_permissions
  has_many :permissions, through: :role_permissions
  accepts_nested_attributes_for :role_permissions
  accepts_nested_attributes_for :permissions
end