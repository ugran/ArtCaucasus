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

ActiveRecord::Schema.define(version: 20141128122928) do

  create_table "artists", force: true do |t|
    t.text     "name"
    t.text     "description"
    t.text     "specialization"
    t.text     "country"
    t.text     "manager"
    t.text     "phone_number"
    t.text     "secondary_phone_number"
    t.text     "email"
    t.text     "secondary_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "carts", force: true do |t|
    t.text     "description"
    t.text     "additional_info"
    t.integer  "item_price"
    t.integer  "shipping_cost"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "item_id"
  end

  add_index "carts", ["item_id"], name: "index_carts_on_item_id"
  add_index "carts", ["user_id"], name: "index_carts_on_user_id"

  create_table "itemimages", force: true do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "itemimages", ["item_id"], name: "index_itemimages_on_item_id"

  create_table "items", force: true do |t|
    t.text     "name"
    t.text     "description"
    t.text     "item_type"
    t.text     "date_of_creation"
    t.text     "dimensions"
    t.text     "additional_info"
    t.integer  "price"
    t.integer  "discount"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artist_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "items", ["artist_id"], name: "index_items_on_artist_id"

  create_table "orders", force: true do |t|
    t.text     "tracking_number"
    t.text     "status"
    t.text     "description"
    t.text     "additional_info"
    t.integer  "u_id"
    t.integer  "item_price"
    t.integer  "shipping_cost"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "item_id"
  end

  add_index "orders", ["item_id"], name: "index_orders_on_item_id"
  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "users", force: true do |t|
    t.text     "email",                  default: "",    null: false
    t.text     "encrypted_password",     default: "",    null: false
    t.text     "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.text     "current_sign_in_ip"
    t.text     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
