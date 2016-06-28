class Role < ActiveRecord::Base
  has_many :permissions
  has_many :permission_types, through: :permissions
  accepts_nested_attributes_for :permissions
  accepts_nested_attributes_for :permission_types
end