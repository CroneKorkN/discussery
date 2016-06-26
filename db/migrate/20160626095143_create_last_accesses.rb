class CreateLastAccesses < ActiveRecord::Migration[5.0]
  def change
    create_table :last_accesses do |t|
      t.references :user, foreign_key: true
      t.references :topic, foreign_key: true
      t.time :time
    end
  end
end
