class AddCreatorToGroup < ActiveRecord::Migration[5.0]
  def change
    add_reference :groups, :creator, references: :users, foreign_key: true, index: true
  end
end
