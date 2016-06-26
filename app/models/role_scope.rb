class RoleScope < ApplicationRecord
  belongs_to :group
  belongs_to :role
  belongs_to :scopable, polymorphic: true
end
