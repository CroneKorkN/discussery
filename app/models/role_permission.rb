class RolePermission < ActiveRecord::Base # role applied
  belongs_to :role
  belongs_to :permission
  accepts_nested_attributes_for :permission
end
