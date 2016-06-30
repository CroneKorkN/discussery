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

# role_types
admin_role_type = RoleType.create name: "admin"
mod_role_type = RoleType.create name: "mod"
member_role_type = RoleType.create name: "user"
guest_role_type = RoleType.create name: "guest"
blocked_role_type = RoleType.create name: "blocked"

# permission_types
visibility_permission_type = PermissionType.create action: :read
[ # admin
  "admin",
  "create_topic",
  "create_post",
  "read_topics"
].each do |action|
  PermissionType.create action: action
end
  
# role_type permission_types
[ # admin
  "admin",
  "create_topic",
  "create_post",
  "read_topics",
  "read",
].each do |action|
  admin_role_type.permissions.create permission_type: PermissionType[action]
end
[ # mod
  "create_topic",
  "create_post",
  "read_topics",
  "read",
].each do |action|
  mod_role_type.permissions.create permission_type: PermissionType[action]
end
[ # member
  "create_topic",
  "create_post",
  "read_topics",
  "read",
].each do |action|
  member_role_type.permissions.create permission_type: PermissionType[action]
end
[ # guest
  "read_topics",
  "read",
].each do |action|
  guest_role_type.permissions.create permission_type: PermissionType[action]
end

PermissionType.all.each do |permission_type|
  blocked_role_type.permissions.create permission_type: permission_type, denied: true
end

# media
avatar_placeholder_medium = Medium.create file: File.new("#{Rails.root}/app/assets/images/avatar.svg")

# users
random = (0...128).map { (65 + rand(26)).chr }.join
admin_user = User.create name: "admin", password: "admin", password_confirmation: "admin", mail: "admin"
system_user = User.create name: "SYSTEM", password: random, password_confirmation: random, mail: "nothing"
example_user = User.create name: "Jon Doe", password: "admin", password_confirmation: "admin", mail: "jon.doe@example.com", medium: Medium.create(file: File.new("#{Rails.root}/app/assets/images/example_avatar_1.png"))

# setting groups
setting_group = SettingGroup.create name: "default"

# settings
{
  visibility_permission_type_id: visibility_permission_type.id,
  threads_per_page: 20,
  avatar_placeholder_medium_id: avatar_placeholder_medium.id,
  system_user_id: system_user.id
}.each do |key, value|
  setting_group.settings.create key: key, value: value
end

# threads
example_topic = example_category.topics.create user: admin_user, name: "hello world!"

# posts
6.times do
  example_topic.posts.create user: admin_user, content: TextGenerator.text
  example_topic.posts.create user: example_user, content: TextGenerator.text
end

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
staff_group.has_members.create member: admin_group
staff_group.has_members.create member: supermod_group

# more settings
{
  admin_group_id: admin_group.id,
  member_group_id: member_group.id,
  root_category_id: root_category.id,
}.each do |key, value|
  setting_group.settings.create key: key, value: value
end

# user groups
admin_group.has_members.create member: admin_user
member_group.has_members.create member: example_user

# group role_types
admin_group.roles.create    role_type: admin_role_type,   protectable: root_category, recursive: true
supermod_group.roles.create role_type: mod_role_type,     protectable: root_category, recursive: true
member_group.roles.create   role_type: member_role_type,  protectable: root_category, recursive: true
guest_group.roles.create    role_type: guest_role_type,   protectable: root_category, recursive: true
blocked_group.roles.create  role_type: blocked_role_type, protectable: root_category, recursive: true