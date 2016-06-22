class BackendController < ApplicationController
  layout "backend"
  def show

  end

  def initialize_app
    # Settings
    Setting.create(
      name:  "avatar_placeholder_medium_id",
      key:   "avatar_placeholder_medium_id",
      value: 1
    )

    # Test-Kategorie
    Category.create(
      name: "Test-Kategorie",
      description: "Beschreibung der Test-Kategorie"
    )

    # Permissions
    permission_read_category = Permission.create(
      controller: "Category",
      action:     "read"
    )
    permission_create_topic = Permission.create(
      controller: "Topic",
      action:     "create"
    )
    permission_read_topic = Permission.create(
      controller: "Topic",
      action:     "read"
    )

    # Roles
    admin_role = Role.create(name: "admin")
    mod_role   = Role.create(name: "moderator")
    member_role  = Role.create(name: "member")

    # Assign Roles
    mod_role.create_role_permission permission: permission_read_category
    mod_role.create_role_permission permission: permission_create_topic
    mod_role.create_role_permission permission: permission_read_topic
  end
end
