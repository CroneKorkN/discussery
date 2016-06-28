# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# categories
root_category = Category.create name: "ROOT"
discussion_category = root_category.categories.create name: "Discussions"
example_category = discussion_category.categories.create name: "Politics"
discussion_category.categories.create name: "Science"

# roles
admin_role = Role.create name: "admin"
mod_role = Role.create name: "mod"
member_role = Role.create name: "user"
guest_role = Role.create name: "guest"
blocked_role = Role.create name: "blocked"

# permissions
visibility_permission = Permission.create action: :read
[ # admin
  "admin",
  "create_topic",
  "create_post",
  "read_topics"
].each do |action|
  Permission.create action: action
end
  
# role permissions
[ # admin
  "admin",
  "create_topic",
  "create_post",
  "read_topics",
  "read",
].each do |action|
  admin_role.role_permissions.create permission: Permission[action]
end
[ # mod
  "create_topic",
  "create_post",
  "read_topics",
  "read",
].each do |action|
  mod_role.role_permissions.create permission: Permission[action]
end
[ # member
  "create_topic",
  "create_post",
  "read_topics",
  "read",
].each do |action|
  member_role.role_permissions.create permission: Permission[action]
end
[ # guest
  "read_topics",
  "read",
].each do |action|
  guest_role.role_permissions.create permission: Permission[action]
end

Permission.all.each do |permission|
  blocked_role.role_permissions.create permission: permission, denied: true
end

# users
random = (0...128).map { (65 + rand(26)).chr }.join
admin_user = User.create name: "admin", password: "admin", password_confirmation: "admin", mail: "admin"
system_user = User.create name: "SYSTEM", password: random, password_confirmation: random, mail: "nothing"
example_user = User.create name: "Jon Doe", password: "admin", password_confirmation: "admin", mail: "jon.doe@example.com"

# contacts
admin_user.contact_links.create contact: example_user

# groups
admin_group = system_user.groups_created.create name: "admins"
supermod_group = system_user.groups_created.create name: "supermods"
member_group = system_user.groups_created.create name: "members"
guest_group = system_user.groups_created.create name: "guests"
blocked_group = system_user.groups_created.create name: "blocked"
example_group = example_user.groups_created.create name: "Example Group"
staff_group = system_user.groups_created.create name: "staff"
staff_group.memberships.create member: admin_group
staff_group.memberships.create member: supermod_group

# user groups
admin_group.memberships.create member: admin_user
member_group.memberships.create member: example_user

# group roles
admin_group.role_scopes.create    role: admin_role,   scopable: root_category, recursive: true
supermod_group.role_scopes.create role: mod_role,     scopable: root_category, recursive: true
member_group.role_scopes.create   role: member_role,  scopable: root_category, recursive: true
guest_group.role_scopes.create    role: guest_role,   scopable: root_category, recursive: true
blocked_group.role_scopes.create  role: blocked_role, scopable: root_category, recursive: true

# media
avatar_placeholder_medium = Medium.create file: File.new("#{Rails.root}/app/assets/images/avatar.svg")

# setting groups
setting_group = SettingGroup.create name: "default"

# settings
{
  visibility_permission_id: visibility_permission.id,
  threads_per_page: 20,
  admin_group_id: admin_group.id,
  member_group_id: member_group.id,
  root_category_id: root_category.id,
  avatar_placeholder_medium_id: avatar_placeholder_medium.id,
  system_user_id: system_user.id
}.each do |key, value|
  setting_group.settings.create key: key, value: value
end

# threads
example_topic = example_category.topics.create user: admin_user, name: "hello world!"
3.times do
  example_topic.posts.create user: admin_user, content: "hallo welt!"
end