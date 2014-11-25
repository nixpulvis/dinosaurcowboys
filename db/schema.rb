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

ActiveRecord::Schema.define(version: 20141125163950) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accesses", force: true do |t|
    t.string   "permission", null: false
    t.integer  "rank_id",    null: false
    t.integer  "forum_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accesses", ["forum_id"], name: "index_accesses_on_forum_id", using: :btree
  add_index "accesses", ["rank_id"], name: "index_accesses_on_rank_id", using: :btree

  create_table "applications", force: true do |t|
    t.integer  "user_id",                         null: false
    t.integer  "status",          default: 0
    t.string   "name"
    t.integer  "age",                             null: false
    t.integer  "gender",                          null: false
    t.string   "battlenet",                       null: false
    t.text     "logs"
    t.text     "computer",                        null: false
    t.text     "raiding_history",                 null: false
    t.text     "guild_history",                   null: false
    t.text     "leadership",                      null: false
    t.text     "playstyle",                       null: false
    t.text     "why",                             null: false
    t.text     "referer",                         null: false
    t.text     "animal",                          null: false
    t.text     "additional"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hidden",          default: false
  end

  add_index "applications", ["user_id"], name: "index_applications_on_user_id", using: :btree

  create_table "bosses", force: true do |t|
    t.string   "name",                       null: false
    t.text     "content"
    t.integer  "raid_id",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hidden",     default: true
    t.integer  "row_order",  default: 0,     null: false
    t.text     "updates"
    t.boolean  "sticky",     default: false
  end

  add_index "bosses", ["raid_id"], name: "index_bosses_on_raid_id", using: :btree

  create_table "characters", force: true do |t|
    t.string   "name",                                      null: false
    t.string   "server",                                    null: false
    t.boolean  "main",                       default: true, null: false
    t.integer  "user_id",                                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "klass"
    t.integer  "level"
    t.integer  "achievement_points"
    t.integer  "average_item_level_equiped"
    t.string   "spec"
    t.string   "role"
    t.string   "thumbnail"
    t.string   "guild_name"
  end

  add_index "characters", ["user_id"], name: "index_characters_on_user_id", using: :btree

  create_table "features", force: true do |t|
    t.string   "title",      null: false
    t.text     "body",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forums", force: true do |t|
    t.string   "name",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "row_order",  default: 0, null: false
  end

  create_table "impressions", force: true do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", using: :btree
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id", using: :btree

  create_table "posts", force: true do |t|
    t.text     "body",          null: false
    t.integer  "postable_id",   null: false
    t.string   "postable_type", null: false
    t.integer  "user_id",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["postable_id"], name: "index_posts_on_postable_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "raids", force: true do |t|
    t.string   "name",                                     null: false
    t.integer  "tier",                                     null: false
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hidden",                    default: true
    t.string   "banner_photo_file_name"
    t.string   "banner_photo_content_type"
    t.integer  "banner_photo_file_size"
    t.datetime "banner_photo_updated_at"
  end

  create_table "ranks", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recruitment_classes", force: true do |t|
    t.string   "class_name", null: false
    t.text     "desires",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shouts", force: true do |t|
    t.string   "shout",                      null: false
    t.boolean  "hidden",     default: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: true do |t|
    t.string   "title",                      null: false
    t.integer  "forum_id",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",                    null: false
    t.boolean  "sticky",     default: false, null: false
  end

  add_index "topics", ["forum_id"], name: "index_topics_on_forum_id", using: :btree
  add_index "topics", ["user_id"], name: "index_topics_on_user_id", using: :btree

  create_table "uploads", force: true do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.integer  "rank_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                  default: false, null: false
    t.integer  "avatar_id"
    t.boolean  "raid_moderator"
    t.boolean  "hidden",                 default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["rank_id"], name: "index_users_on_rank_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
