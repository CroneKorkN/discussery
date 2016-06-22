class RemoveFileFromMedium < ActiveRecord::Migration
  def change
    remove_column :media, :file, :string
  end
end
