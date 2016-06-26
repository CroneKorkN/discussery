class AddBackgroundToGroup < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :background, :boolean, default: false, null: false
    add_index :groups, :background
  end
end
