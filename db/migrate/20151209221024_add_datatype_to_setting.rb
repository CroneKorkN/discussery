class AddDatatypeToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :datatype, :string
  end
end
