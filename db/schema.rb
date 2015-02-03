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

ActiveRecord::Schema.define(version: 20150129071323) do

  create_table "artists", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "specialization"
    t.string   "country"
    t.string   "manager"
    t.string   "phone_number"
    t.string   "secondary_phone_number"
    t.string   "email"
    t.string   "secondary_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "carousels", force: true do |t|
    t.string   "headline"
    t.text     "description"
    t.integer  "item_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "carousels", ["item_id"], name: "index_carousels_on_item_id"

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

  create_table "comments", force: true do |t|
    t.text     "ccontent"
    t.integer  "user_id"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["item_id"], name: "index_comments_on_item_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "itemimages", force: true do |t|
    t.string   "description"
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
    t.string   "name"
    t.text     "description"
    t.string   "item_type"
    t.string   "item_tag"
    t.string   "date_of_creation"
    t.string   "dimensions"
    t.string   "weight"
    t.string   "shipping"
    t.text     "additional_info"
    t.integer  "sold_out",           default: 0, null: false
    t.integer  "price"
    t.integer  "discount",           default: 0, null: false
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artist_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "comments_count",     default: 0
    t.integer  "likes_count",        default: 0
    t.string   "artist_name"
  end

  add_index "items", ["artist_id"], name: "index_items_on_artist_id"

  create_table "likes", force: true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["item_id"], name: "index_likes_on_item_id"
  add_index "likes", ["user_id"], name: "index_likes_on_user_id"

  create_table "orders", force: true do |t|
    t.string   "tracking_number"
    t.string   "status"
    t.string   "p_invoice_number"
    t.string   "p_gross_amount"
    t.string   "p_auth_amount"
    t.string   "p_shipping"
    t.string   "p_auth_expiration_date"
    t.string   "p_address_status"
    t.string   "p_payer_id"
    t.string   "p_address_street"
    t.string   "p_payment_date"
    t.string   "p_zipcode"
    t.string   "p_paypal_name"
    t.string   "p_paypal_lastname"
    t.string   "p_shipping_name"
    t.string   "p_custom"
    t.string   "p_country"
    t.string   "p_city"
    t.string   "p_email"
    t.string   "p_txn_id"
    t.string   "p_state"
    t.string   "p_item_name"
    t.string   "p_item_number"
    t.string   "p_ipn_tracking_id"
    t.string   "p_contact_phone"
    t.text     "description"
    t.text     "additional_info"
    t.integer  "item_price"
    t.integer  "shipping_cost"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "userinfos", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "country"
    t.text     "address"
    t.string   "phone"
    t.string   "zipcode"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "region"
    t.string   "city"
  end

  add_index "userinfos", ["user_id"], name: "index_userinfos_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name",                   default: "",    null: false
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
