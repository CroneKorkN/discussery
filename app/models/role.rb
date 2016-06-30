class Role < ApplicationRecord
  belongs_to :group
  belongs_to :role_type
  belongs_to :protectable, polymorphic: true
end
