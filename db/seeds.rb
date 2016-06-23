# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.creat name: "admin", password: "admin", mail: "admin"

setting_group = SettingGroup.create name: "default"
setting_group.settings.create key: "threads_per_page", value: 20

admin_role = Role.create name: "admin"
mod_role = Role.create name: "mod"
user_role = Role.create name: "user"
guest_role = Role.create name: "guest"

