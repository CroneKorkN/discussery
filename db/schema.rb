# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151216160859) do

  create_table "attachments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "post_id"
    t.integer  "medium_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "attachments", ["medium_id"], name: "index_attachments_on_medium_id", using: :btree
  add_index "attachments", ["post_id"], name: "index_attachments_on_post_id", using: :btree

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.text     "description", limit: 65535
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "parent_id",                 default: 0
    t.integer  "category_id"
  end

  add_index "categories", ["category_id"], name: "index_categories_on_category_id", using: :btree
  add_index "categories", ["name"], name: "index_categories_on_name", using: :btree
  add_index "categories", ["parent_id"], name: "index_categories_on_parent_id", using: :btree

  create_table "group_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "group_users", ["group_id"], name: "index_group_users_on_group_id", using: :btree
  add_index "group_users", ["user_id"], name: "index_group_users_on_user_id", using: :btree

  create_table "groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "groups", ["name"], name: "index_groups_on_name", using: :btree

  create_table "media", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "user_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "media", ["user_id"], name: "index_media_on_user_id", using: :btree

  create_table "permissions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "controller"
    t.string   "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "permissions", ["action"], name: "index_permissions_on_action", using: :btree
  add_index "permissions", ["controller"], name: "index_permissions_on_controller", using: :btree

  create_table "posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.text     "content",            limit: 65535
    t.text     "content_searchable", limit: 65535
    t.integer  "topic_id"
    t.integer  "user_id"
    t.datetime "date"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "posts", ["date"], name: "index_posts_on_date", using: :btree
  add_index "posts", ["topic_id"], name: "index_posts_on_topic_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "role_permissions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "role_id"
    t.integer  "permission_id"
    t.integer  "grant"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "role_permissions", ["permission_id"], name: "index_role_permissions_on_permission_id", using: :btree
  add_index "role_permissions", ["role_id"], name: "index_role_permissions_on_role_id", using: :btree

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "setting_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.integer  "setting_group_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "setting_groups", ["name"], name: "index_setting_groups_on_name", using: :btree
  add_index "setting_groups", ["setting_group_id"], name: "index_setting_groups_on_setting_group_id", using: :btree

  create_table "settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "key"
    t.text     "value",            limit: 65535
    t.string   "name"
    t.text     "description",      limit: 65535
    t.integer  "setting_group_id"
    t.integer  "order"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "datatype"
  end

  add_index "settings", ["key"], name: "index_settings_on_key", using: :btree
  add_index "settings", ["name"], name: "index_settings_on_name", using: :btree
  add_index "settings", ["order"], name: "index_settings_on_order", using: :btree
  add_index "settings", ["setting_group_id"], name: "index_settings_on_setting_group_id", using: :btree

  create_table "topics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "topics", ["category_id"], name: "index_topics_on_category_id", using: :btree
  add_index "topics", ["name"], name: "index_topics_on_name", using: :btree
  add_index "topics", ["user_id"], name: "index_topics_on_user_id", using: :btree

  create_table "user_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_groups", ["group_id"], name: "index_user_groups_on_group_id", using: :btree
  add_index "user_groups", ["user_id"], name: "index_user_groups_on_user_id", using: :btree

  create_table "user_roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
    t.boolean  "recursive"
  end

  add_index "user_roles", ["category_id"], name: "index_user_roles_on_category_id", using: :btree
  add_index "user_roles", ["recursive"], name: "index_user_roles_on_recursive", using: :btree
  add_index "user_roles", ["role_id"], name: "index_user_roles_on_role_id", using: :btree
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.string   "mail"
    t.string   "password"
    t.string   "password_digest"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.text     "acl_cache",       limit: 65535
    t.integer  "medium_id"
  end

  add_index "users", ["mail"], name: "index_users_on_mail", using: :btree
  add_index "users", ["medium_id"], name: "index_users_on_medium_id", using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree

  add_foreign_key "attachments", "media"
  add_foreign_key "attachments", "posts"
  add_foreign_key "categories", "categories"
  add_foreign_key "group_users", "groups"
  add_foreign_key "group_users", "users"
  add_foreign_key "media", "users"
  add_foreign_key "posts", "topics"
  add_foreign_key "posts", "users"
  add_foreign_key "role_permissions", "permissions"
  add_foreign_key "role_permissions", "roles"
  add_foreign_key "setting_groups", "setting_groups"
  add_foreign_key "settings", "setting_groups"
  add_foreign_key "topics", "categories"
  add_foreign_key "topics", "users"
  add_foreign_key "user_groups", "groups"
  add_foreign_key "user_groups", "users"
  add_foreign_key "user_roles", "categories"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
  add_foreign_key "users", "media"
end
