class AddTrashToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :trash, :boolean, null: false, default: false
    add_index :posts, :trash
  end
end
