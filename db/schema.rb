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

ActiveRecord::Schema.define(:version => 20110814224612) do

  create_table "alpha_testers", :force => true do |t|
    t.integer  "facebook_id", :limit => 8
    t.boolean  "authorized"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.string   "provider_user_name"
    t.string   "secret"
  end

  create_table "foursquare_checkins", :force => true do |t|
    t.string   "venue_id"
    t.integer  "user_id"
    t.string   "checkin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredients", :force => true do |t|
    t.string   "ingredient"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_item_ingredients", :force => true do |t|
    t.integer  "menu_item_id"
    t.integer  "ingredient_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_item_photos", :force => true do |t|
    t.integer  "menu_item_id"
    t.string   "photo"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_item_prices", :force => true do |t|
    t.integer  "menu_item_id"
    t.string   "price_for"
    t.decimal  "price"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_item_rating_helpfuls", :force => true do |t|
    t.integer  "menu_item_rating_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_item_ratings", :force => true do |t|
    t.integer  "menu_item_id"
    t.integer  "user_id"
    t.integer  "rating"
    t.text     "review"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_item_review_comments", :force => true do |t|
    t.integer  "menu_item_rating_id"
    t.integer  "user_id"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_items", :force => true do |t|
    t.integer  "restaurant_id"
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "price"
  end

  create_table "menu_label_associations", :force => true do |t|
    t.integer  "menu_item_id"
    t.integer  "menu_label_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_labels", :force => true do |t|
    t.string   "menu_label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "restaurant_cuisine_associations", :force => true do |t|
    t.integer  "restaurant_id"
    t.integer  "restaurant_cuisine_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "restaurant_cuisines", :force => true do |t|
    t.string   "restaurant_cuisine"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "restaurant_label_associations", :force => true do |t|
    t.integer  "restaurant_id"
    t.integer  "restaurant_label_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "restaurant_labels", :force => true do |t|
    t.string   "restaurant_label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "restaurants", :force => true do |t|
    t.string   "name"
    t.string   "street_address"
    t.string   "neighborhood"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.string   "cross_street"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.point    "latitude_longitude",  :limit => nil
    t.float    "latitude"
    t.float    "longitude"
    t.point    "geom",                :limit => nil, :srid => 32661
    t.string   "twitter"
    t.integer  "telephone",           :limit => 8
    t.string   "foursquare_venue_id"
  end

  add_index "restaurants", ["latitude_longitude"], :name => "index_restaurants_on_latitude_longitude", :spatial => true

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "temp_images", :force => true do |t|
    t.string   "hash"
    t.string   "image_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_followings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "following_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_saved_menu_items", :force => true do |t|
    t.integer  "user_id"
    t.integer  "menu_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_vote_cities", :force => true do |t|
    t.string   "email"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "user_name"
    t.integer  "facebook_id"
    t.integer  "twitter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_profile_pic_url"
    t.integer  "user_ratings_count",             :default => 0
    t.string   "email"
    t.string   "telephone"
    t.datetime "last_logged_in"
    t.string   "bio"
    t.boolean  "admin"
    t.boolean  "get_foursquare_recommendations", :default => false
    t.boolean  "auto_post_to_facebook",          :default => false
    t.boolean  "auto_post_to_twitter",           :default => false
    t.boolean  "auto_post_to_foursquare",        :default => false
  end

end
