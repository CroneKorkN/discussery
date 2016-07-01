class Role < ApplicationRecord
  belongs_to :role_type
  has_many :permission_types,
    through: :role_type
  belongs_to :permittable,
    polymorphic: true
  belongs_to :protectable,
    polymorphic: true
end
