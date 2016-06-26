class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :type, index: true, null: false
      t.string :location, index: true, null: false

      t.timestamps null: false
    end
  end
end
