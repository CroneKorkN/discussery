class Post < ApplicationRecord
  belongs_to :postable,
    polymorphic: true
  belongs_to :user
  default_scope ->{where(trash: false)}
  
  def container
    postable.container
  end
  
  after_create do
    postable.update latest_activity_at: updated_at
    
    user.subscribe self
  end
  
end