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

ActiveRecord::Schema.define(version: 20160803200719) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "order_services", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "user_service_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "order_services", ["order_id"], name: "index_order_services_on_order_id", using: :btree
  add_index "order_services", ["user_service_id"], name: "index_order_services_on_user_service_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.datetime "date"
    t.string   "description"
    t.text     "information"
    t.integer  "user_id"
    t.integer  "state_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "provider_id"
  end

  add_index "orders", ["provider_id"], name: "index_orders_on_provider_id", using: :btree
  add_index "orders", ["state_id"], name: "index_orders_on_state_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "schedules", force: :cascade do |t|
    t.datetime "starttime"
    t.datetime "endtime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "schedules", ["user_id"], name: "index_schedules_on_user_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "surveys", force: :cascade do |t|
    t.integer  "stars"
    t.text     "comments"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "surveys", ["order_id"], name: "index_surveys_on_order_id", using: :btree

  create_table "user_services", force: :cascade do |t|
    t.integer  "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "user_services", ["service_id"], name: "index_user_services_on_service_id", using: :btree
  add_index "user_services", ["user_id"], name: "index_user_services_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.text     "address"
    t.string   "phone"
    t.boolean  "is_provider"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "order_services", "orders"
  add_foreign_key "order_services", "user_services"
  add_foreign_key "orders", "states"
  add_foreign_key "orders", "users"
  add_foreign_key "orders", "users", column: "provider_id"
  add_foreign_key "schedules", "users"
  add_foreign_key "surveys", "orders"
  add_foreign_key "user_services", "services"
  add_foreign_key "user_services", "users"
end
