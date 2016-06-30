class RemoveGroupFromRole < ActiveRecord::Migration[5.0]
  def change
    remove_reference :roles, :group, foreign_key: true
  end
end
