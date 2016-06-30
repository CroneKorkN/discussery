class Post < ApplicationRecord
  belongs_to :postable,
    polymorphic: true
  belongs_to :user
  
  after_create do
    postable.update latest_activity_at: updated_at
  end
end
