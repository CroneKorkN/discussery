class Permission < ActiveRecord::Base # role_type applied
  belongs_to :role_type
  belongs_to :permission_type
  accepts_nested_attributes_for :permission_type
end
