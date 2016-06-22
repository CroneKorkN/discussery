class AddMediumToUser < ActiveRecord::Migration
  def change
    add_reference :users, :medium, index: true, foreign_key: true
  end
end
