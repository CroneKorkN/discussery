class AddPermittableToRole < ActiveRecord::Migration[5.0]
  def change
    add_reference :roles, :permittable, polymorphic: true
  end
end
