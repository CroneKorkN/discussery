class AddCategoryToUserRoles < ActiveRecord::Migration
  def change
    add_reference :user_roles, :category, index: true, foreign_key: true
  end
end
