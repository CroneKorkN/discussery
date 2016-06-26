# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160626101041) do

  create_table "attachments", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "medium_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medium_id"], name: "index_attachments_on_medium_id"
    t.index ["post_id"], name: "index_attachments_on_post_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "parent_id",   default: 0
    t.integer  "category_id"
    t.index ["category_id"], name: "index_categories_on_category_id"
    t.index ["name"], name: "index_categories_on_name"
    t.index ["parent_id"], name: "index_categories_on_parent_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_contacts_on_contact_id"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "group_groups", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "member_group_id", default: 0, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["group_id"], name: "index_group_groups_on_group_id"
    t.index ["member_group_id"], name: "index_group_groups_on_member_group_id"
  end

  create_table "group_users", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "index_groups_on_name"
  end

  create_table "last_accesses", force: :cascade do |t|
    t.integer "user_id"
    t.integer "topic_id"
    t.time    "time"
    t.index ["topic_id"], name: "index_last_accesses_on_topic_id"
    t.index ["user_id"], name: "index_last_accesses_on_user_id"
  end

  create_table "media", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "user_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.index ["user_id"], name: "index_media_on_user_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string   "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["action"], name: "index_permissions_on_action"
  end

  create_table "posts", force: :cascade do |t|
    t.text     "content"
    t.text     "content_searchable"
    t.integer  "topic_id"
    t.integer  "user_id"
    t.datetime "date"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["date"], name: "index_posts_on_date"
    t.index ["topic_id"], name: "index_posts_on_topic_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "role_permissions", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "permission_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "denied",        default: false, null: false
    t.index ["permission_id"], name: "index_role_permissions_on_permission_id"
    t.index ["role_id"], name: "index_role_permissions_on_role_id"
  end

  create_table "role_scopes", force: :cascade do |t|
    t.integer "group_id"
    t.integer "role_id"
    t.string  "scopable_type"
    t.integer "scopable_id"
    t.boolean "recursive",     default: false, null: false
    t.index ["group_id"], name: "index_role_scopes_on_group_id"
    t.index ["role_id"], name: "index_role_scopes_on_role_id"
    t.index ["scopable_type", "scopable_id"], name: "index_role_scopes_on_scopable_type_and_scopable_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "setting_groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "setting_group_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["name"], name: "index_setting_groups_on_name"
    t.index ["setting_group_id"], name: "index_setting_groups_on_setting_group_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string   "key"
    t.text     "value"
    t.string   "name"
    t.text     "description"
    t.integer  "setting_group_id"
    t.integer  "order"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "datatype"
    t.index ["key"], name: "index_settings_on_key"
    t.index ["name"], name: "index_settings_on_name"
    t.index ["order"], name: "index_settings_on_order"
    t.index ["setting_group_id"], name: "index_settings_on_setting_group_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_topics_on_category_id"
    t.index ["name"], name: "index_topics_on_name"
    t.index ["user_id"], name: "index_topics_on_user_id"
  end

  create_table "user_groups", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_user_groups_on_group_id"
    t.index ["user_id"], name: "index_user_groups_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",            null: false
    t.string   "mail",            null: false
    t.string   "password"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "acl_cache"
    t.integer  "medium_id"
    t.index ["mail"], name: "index_users_on_mail"
    t.index ["medium_id"], name: "index_users_on_medium_id"
    t.index ["name"], name: "index_users_on_name"
  end

end
