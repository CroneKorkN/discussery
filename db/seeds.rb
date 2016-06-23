# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# categories
root_category = Category.create name: "root"
discussion_category = root_category.categories.create name: "Discussions"
discussion_category.categories.create name: "Politics"
discussion_category.categories.create name: "Science"

# roles
admin_role = Role.create name: "admin"
mod_role = Role.create name: "mod"
member_role = Role.create name: "user"
guest_role = Role.create name: "guest"
blocked_role = Role.create name: "blocked"

# permissions
[ # admin
  "admin",
  "create_topic",
  "create_post",
  "read_topics",
  "read_category",
].each do |action|
  admin_role.permissions.create action: action
end
[ # mod
  "create_topic",
  "create_post",
  "read_topics",
  "read_category",
].each do |action|
  mod_role.permissions.create action: action
end
[ # member
  "create_topic",
  "create_post",
  "read_topics",
  "read_category",
].each do |action|
  member_role.permissions.create action: action
end
[ # guest
  "read_topics",
  "read_category",
].each do |action|
  guest_role.permissions.create action: action
end

Permission.all.each do |permission|
  blocked_role.role_permissions.create permission: permission, denied: true
end

# groups
admin_group = Group.create name: "admins"
supermod_group = Group.create name: "supermods"
member_group = Group.create name: "members"
guest_group = Group.create name: "guests"
blocked_group = Group.create name: "blocked"
staff_group = Group.create(name: "staff")
staff_group.group_groups.create member_group: admin_group
staff_group.group_groups.create member_group: supermod_group

# group roles
admin_group.roles.create name: admin_role.name
supermod_group.roles.create name: mod_role.name
member_group.roles.create name: member_role.name
guest_group.roles.create name: guest_role.name
blocked_group.roles.create name: blocked_role.name

# users
admin = admin_group.users.create name: "admin", password: "admin", password_confirmation: "admin", mail: "admin"

# setting groups
setting_group = SettingGroup.create name: "default"

# settings
setting_group.settings.create key: "root_category", value: root_category.id
setting_group.settings.create key: "threads_per_page", value: 20
setting_group.settings.create key: "admin_group_id", value: admin_group.id
setting_group.settings.create key: "member_group_id", value: member_group.id