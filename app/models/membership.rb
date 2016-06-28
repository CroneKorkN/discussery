class Membership < ApplicationRecord
  belongs_to :group
  belongs_to :member,
   polymorphic: true
end
