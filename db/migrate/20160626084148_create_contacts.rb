class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.references :user, foreign_key: true
      t.references :contact, foreign_key: :contact_id

      t.timestamps
    end
  end
end
