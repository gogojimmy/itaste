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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121118040311) do

  create_table "badges", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "foods", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "foods", ["name"], :name => "index_foods_on_name"

  create_table "grape_region_ships", :force => true do |t|
    t.integer  "grape_id"
    t.integer  "region_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "grape_region_ships", ["grape_id"], :name => "index_grape_region_ships_on_grape_id"
  add_index "grape_region_ships", ["region_id"], :name => "index_grape_region_ships_on_region_id"

  create_table "grapes", :force => true do |t|
    t.string   "name"
    t.text     "taste"
    t.text     "nose"
    t.text     "appearance"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "places", :force => true do |t|
    t.string   "name"
    t.decimal  "lat",        :precision => 15, :scale => 10
    t.decimal  "lon",        :precision => 15, :scale => 10
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  add_index "places", ["lat"], :name => "index_places_on_lat"
  add_index "places", ["lon"], :name => "index_places_on_lon"

  create_table "producers", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "region_id"
    t.decimal  "lat",         :precision => 15, :scale => 10
    t.decimal  "lon",         :precision => 15, :scale => 10
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "regions", ["parent_id"], :name => "index_regions_on_parent_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "username",               :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["provider"], :name => "index_users_on_provider"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["uid"], :name => "index_users_on_uid"
  add_index "users", ["username"], :name => "index_users_on_username"

  create_table "wine_badge_ships", :force => true do |t|
    t.integer  "wine_id"
    t.integer  "badge_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "wine_badge_ships", ["badge_id"], :name => "index_wine_badge_ships_on_badge_id"
  add_index "wine_badge_ships", ["wine_id"], :name => "index_wine_badge_ships_on_wine_id"

  create_table "wine_food_ships", :force => true do |t|
    t.integer  "wine_id"
    t.integer  "food_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "wine_food_ships", ["food_id"], :name => "index_wine_food_ships_on_food_id"
  add_index "wine_food_ships", ["wine_id"], :name => "index_wine_food_ships_on_wine_id"

  create_table "wine_grape_ships", :force => true do |t|
    t.integer  "wine_id"
    t.integer  "grape_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "wine_grape_ships", ["grape_id"], :name => "index_wine_grape_ships_on_grape_id"
  add_index "wine_grape_ships", ["wine_id"], :name => "index_wine_grape_ships_on_wine_id"

  create_table "wines", :force => true do |t|
    t.string   "name"
    t.string   "wine_type"
    t.integer  "vintage"
    t.integer  "user_id"
    t.decimal  "alcohol",                  :precision => 6, :scale => 5
    t.integer  "producer_id"
    t.integer  "region_id"
    t.integer  "serving_temperature_from"
    t.integer  "serving_temperature_to"
    t.string   "suggested_glass"
    t.float    "price"
    t.datetime "when"
    t.integer  "place_id"
    t.text     "appearance"
    t.text     "nose"
    t.text     "taste"
    t.text     "opinion"
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
  end

  add_index "wines", ["name"], :name => "index_wines_on_name"
  add_index "wines", ["place_id"], :name => "index_wines_on_place_id"
  add_index "wines", ["price"], :name => "index_wines_on_price"
  add_index "wines", ["producer_id"], :name => "index_wines_on_producer_id"
  add_index "wines", ["region_id"], :name => "index_wines_on_region_id"
  add_index "wines", ["user_id"], :name => "index_wines_on_user_id"
  add_index "wines", ["vintage"], :name => "index_wines_on_vintage"
  add_index "wines", ["wine_type"], :name => "index_wines_on_wine_type"

end
