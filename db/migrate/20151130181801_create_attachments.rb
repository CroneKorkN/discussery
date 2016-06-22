class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :post, index: true, foreign_key: true
      t.references :medium, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
