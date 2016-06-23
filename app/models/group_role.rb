class GroupRole < ApplicationRecord
  belongs_to :group
  belongs_to :role
  belongs_to :category, optional: true
end