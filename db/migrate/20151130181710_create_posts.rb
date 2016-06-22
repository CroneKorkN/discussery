class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content
      t.text :content_searchable
      t.references :topic, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.datetime :date

      t.timestamps null: false
    end
    add_index :posts, :date
  end
end
