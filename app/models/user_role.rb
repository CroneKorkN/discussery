class UserRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  belongs_to :category, optional: true
end
