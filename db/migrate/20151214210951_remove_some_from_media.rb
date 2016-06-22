class RemoveSomeFromMedia < ActiveRecord::Migration
  def change
    remove_column :media, :location, :string
    remove_column :media, :type, :string
  end
end
