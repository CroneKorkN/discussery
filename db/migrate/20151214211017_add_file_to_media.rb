class AddFileToMedia < ActiveRecord::Migration
  def change
    add_reference :media, :user, index: true, foreign_key: true
    add_column :media, :file, :string
  end
end
