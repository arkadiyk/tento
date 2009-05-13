# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090511051052) do

  create_table "addresses", :force => true do |t|
    t.string   "postal_code"
    t.string   "prefecture"
    t.string   "city"
    t.string   "address"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts", :force => true do |t|
    t.integer  "user_id"
    t.datetime "confirmed_at"
    t.string   "pay_method"
    t.datetime "paid_at"
    t.datetime "canceled_at"
    t.integer  "ship_to_id"
    t.string   "shipping_comment"
    t.string   "preffered_delivery_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalog_items", :force => true do |t|
    t.integer  "supplier_id"
    t.integer  "item_units_count", :default => 0
    t.string   "item_id"
    t.string   "name_en"
    t.string   "name_ja"
    t.string   "long_name_en"
    t.string   "long_name_ja"
    t.string   "desc_en"
    t.string   "desc_ja"
    t.string   "image_file"
    t.boolean  "active",           :default => true
    t.boolean  "in_stock",         :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalog_items_product_lines", :id => false, :force => true do |t|
    t.integer "catalog_item_id"
    t.integer "product_line_id"
  end

  create_table "current_specials", :force => true do |t|
    t.integer  "catalog_item_id"
    t.integer  "special_type_id"
    t.date     "expires_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_units", :force => true do |t|
    t.integer  "catalog_item_id"
    t.string   "name_en"
    t.string   "name_ja"
    t.decimal  "weight"
    t.integer  "price"
    t.integer  "points"
    t.boolean  "active",          :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "order_id"
    t.integer  "item_unit_id"
    t.integer  "quantity",     :default => 0
    t.integer  "price"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "cart_id"
    t.integer  "supplier_id"
    t.integer  "shipping_cost"
    t.integer  "status",        :default => 0
    t.boolean  "canceled"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", :force => true do |t|
    t.integer  "cart_id"
    t.decimal  "amount"
    t.string   "transaction_id"
    t.string   "status"
    t.string   "who"
    t.string   "params"
    t.string   "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_lines", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name_en"
    t.string   "name_ja"
    t.string   "long_name_en"
    t.string   "long_name_ja"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shipments", :force => true do |t|
    t.integer  "order_id"
    t.string   "tracking_no"
    t.decimal  "weight"
    t.decimal  "price"
    t.boolean  "complete",           :default => true
    t.string   "comments"
    t.datetime "shipped_at"
    t.date     "estimated_delivery"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "special_types", :force => true do |t|
    t.string   "name_en"
    t.string   "name_ja"
    t.string   "long_name_en"
    t.string   "long_name_ja"
    t.string   "type"
    t.string   "rule"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suppliers", :force => true do |t|
    t.string   "name_en"
    t.string   "name_ja"
    t.string   "long_name_en"
    t.string   "long_name_ja"
    t.integer  "address_id"
    t.string   "shipping_rule"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.integer  "shipping_addr_id"
    t.boolean  "verified"
    t.integer  "points"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
