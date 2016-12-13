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

ActiveRecord::Schema.define(version: 20160109194921) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "access_codes", force: :cascade do |t|
    t.string   "code"
    t.integer  "limit"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "access_codes", ["code"], name: "index_access_codes_on_code", using: :btree

  create_table "addresses", force: :cascade do |t|
    t.string   "line_1",         limit: 255
    t.string   "line_2",         limit: 255
    t.string   "city",           limit: 255
    t.string   "state_province", limit: 255
    t.string   "zip_postcode",   limit: 255
    t.string   "country",        limit: 255
    t.integer  "listing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["listing_id"], name: "index_addresses_on_listing_id", using: :btree

  create_table "agent_profiles", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "phone_number", limit: 255
    t.string   "email",        limit: 255
    t.string   "website",      limit: 255
    t.string   "brokerage",    limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "follows", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "listing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["listing_id"], name: "index_follows_on_listing_id", using: :btree
  add_index "follows", ["user_id", "listing_id"], name: "index_follows_on_user_id_and_listing_id", using: :btree

  create_table "listings", force: :cascade do |t|
    t.decimal  "price",                          precision: 20, scale: 2
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name",    limit: 255
    t.string   "photo_content_type", limit: 255
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.date     "expiry_date"
    t.integer  "floor_area"
    t.integer  "building_type"
    t.integer  "building_style"
    t.float    "property_taxes"
    t.datetime "deleted_at"
    t.string   "step",               limit: 255
    t.boolean  "active",                                                  default: false, null: false
  end

  add_index "listings", ["deleted_at"], name: "index_listings_on_deleted_at", using: :btree
  add_index "listings", ["user_id"], name: "index_listings_on_user_id", using: :btree

  create_table "mailing_lists", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.text     "message"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.datetime "deleted_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "notifications", ["deleted_at"], name: "index_notifications_on_deleted_at", using: :btree
  add_index "notifications", ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable_type_and_notifiable_id", using: :btree

  create_table "open_houses", force: :cascade do |t|
    t.datetime "date"
    t.integer  "listing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start"
    t.datetime "end"
  end

  add_index "open_houses", ["listing_id"], name: "index_open_houses_on_listing_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type",     limit: 255
    t.string   "photo",              limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["imageable_id", "imageable_type"], name: "index_photos_on_imageable_id_and_imageable_type", using: :btree

  create_table "plans", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.string   "stripe_plan_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "description"
    t.text     "amount_of_listings"
    t.text     "poster_templates"
    t.text     "notification_permissions"
    t.text     "analytic_package"
    t.text     "support_package"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer  "listing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "properties"
    t.string   "type",       limit: 255
  end

  add_index "rooms", ["listing_id"], name: "index_rooms_on_listing_id", using: :btree
  add_index "rooms", ["properties"], name: "index_rooms_on_properties", using: :gin

  create_table "rpush_apps", force: :cascade do |t|
    t.string   "name",                    limit: 255,             null: false
    t.string   "environment",             limit: 255
    t.text     "certificate"
    t.string   "password",                limit: 255
    t.integer  "connections",                         default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",                    limit: 255,             null: false
    t.string   "auth_key",                limit: 255
    t.string   "client_id",               limit: 255
    t.string   "client_secret",           limit: 255
    t.string   "access_token",            limit: 255
    t.datetime "access_token_expiration"
  end

  create_table "rpush_feedback", force: :cascade do |t|
    t.string   "device_token", limit: 64, null: false
    t.datetime "failed_at",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "app_id"
  end

  add_index "rpush_feedback", ["device_token"], name: "index_rpush_feedback_on_device_token", using: :btree

  create_table "rpush_notifications", force: :cascade do |t|
    t.integer  "badge"
    t.string   "device_token",      limit: 64
    t.string   "sound",             limit: 255, default: "default"
    t.string   "alert",             limit: 255
    t.text     "data"
    t.integer  "expiry",                        default: 86400
    t.boolean  "delivered",                     default: false,     null: false
    t.datetime "delivered_at"
    t.boolean  "failed",                        default: false,     null: false
    t.datetime "failed_at"
    t.integer  "error_code"
    t.text     "error_description"
    t.datetime "deliver_after"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "alert_is_json",                 default: false
    t.string   "type",              limit: 255,                     null: false
    t.string   "collapse_key",      limit: 255
    t.boolean  "delay_while_idle",              default: false,     null: false
    t.text     "registration_ids"
    t.integer  "app_id",                                            null: false
    t.integer  "retries",                       default: 0
    t.string   "uri",               limit: 255
    t.datetime "fail_after"
    t.boolean  "processing",                    default: false,     null: false
    t.integer  "priority"
    t.text     "url_args"
    t.string   "category",          limit: 255
  end

  add_index "rpush_notifications", ["delivered", "failed"], name: "index_rpush_notifications_multi", where: "((NOT delivered) AND (NOT failed))", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "access_token", limit: 255
    t.datetime "expires_at"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid",         limit: 255
    t.string   "push_token",   limit: 255
    t.string   "os",           limit: 255
    t.string   "os_version",   limit: 255
  end

  add_index "sessions", ["access_token"], name: "index_sessions_on_access_token", unique: true, using: :btree
  add_index "sessions", ["user_id"], name: "index_sessions_on_user_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.string   "stripe_sub_id"
    t.datetime "period_start"
    t.datetime "period_end"
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "plan_id"
    t.datetime "deleted_at"
    t.datetime "subscribed_on"
    t.datetime "cancelled_on"
    t.integer  "status",        default: 0
  end

  add_index "subscriptions", ["deleted_at"], name: "index_subscriptions_on_deleted_at", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "user_room_ratings", force: :cascade do |t|
    t.integer  "score"
    t.integer  "user_id"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_room_ratings", ["room_id"], name: "index_user_room_ratings_on_room_id", using: :btree
  add_index "user_room_ratings", ["user_id"], name: "index_user_room_ratings_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",                   limit: 255
    t.boolean  "active",                             default: false
    t.string   "stripe_customer_id"
    t.integer  "access_code_id"
  end

  add_index "users", ["access_code_id"], name: "index_users_on_access_code_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "subscriptions", "users"
end
