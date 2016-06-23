class GroupGroup < ApplicationRecord
  belongs_to :group
  belongs_to :member_group, foreign_key: :member_group_id, class_name: "Group"
end
