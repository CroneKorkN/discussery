class Permission < ActiveRecord::Base # role applied
  belongs_to :role
  belongs_to :permission_type
  accepts_nested_attributes_for :permission_type
end
