class RemoveTypeFromSetting < ActiveRecord::Migration
  def change
    remove_column :settings, :type, :string
  end
end
