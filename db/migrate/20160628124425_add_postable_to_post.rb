class AddPostableToPost < ActiveRecord::Migration[5.0]
  def change
    add_reference :posts, :postable, polymorphic: true
  end
end
