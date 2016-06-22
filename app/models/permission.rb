class Permission < ActiveRecord::Base
  has_many :role_permissions, dependent: :destroy
end
