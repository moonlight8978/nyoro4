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

ActiveRecord::Schema.define(version: 20180420084351) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feed_likes", force: :cascade do |t|
    t.bigint "user_id"
    t.string "likable_type"
    t.bigint "likable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["likable_type", "likable_id"], name: "index_feed_likes_on_likable_type_and_likable_id"
    t.index ["user_id", "likable_id", "likable_type"], name: "feed_likes_likeable"
    t.index ["user_id"], name: "index_feed_likes_on_user_id"
  end

  create_table "feed_retweets", force: :cascade do |t|
    t.bigint "user_id"
    t.string "retweetable_type"
    t.bigint "retweetable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["retweetable_type", "retweetable_id"], name: "index_feed_retweets_on_retweetable_type_and_retweetable_id"
    t.index ["user_id", "retweetable_id", "retweetable_type"], name: "feed_retweets_retweetable"
    t.index ["user_id"], name: "index_feed_retweets_on_user_id"
  end

  create_table "feed_tweets", force: :cascade do |t|
    t.bigint "user_id"
    t.text "content"
    t.boolean "pinned", default: false
    t.integer "replies_count", default: 0
    t.integer "likes_count", default: 0
    t.integer "retweets_count", default: 0
    t.json "photos"
    t.string "video"
    t.string "widths", default: ""
    t.string "heights", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pinned"], name: "index_feed_tweets_on_pinned"
    t.index ["user_id"], name: "index_feed_tweets_on_user_id"
  end

  create_table "feeds", force: :cascade do |t|
    t.string "feedable_type"
    t.bigint "feedable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["feedable_type", "feedable_id"], name: "index_feeds_on_feedable_type_and_feedable_id"
    t.index ["user_id"], name: "index_feeds_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "tweet_hashtags", force: :cascade do |t|
    t.string "name"
    t.integer "tweets_count", default: 0
    t.integer "replies_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_tweet_hashtags_on_slug"
  end

  create_table "tweet_mentionings", force: :cascade do |t|
    t.bigint "user_id"
    t.string "mentionable_type"
    t.bigint "mentionable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mentionable_type", "mentionable_id"], name: "index_tweet_mentionings_on_mentionable_type_and_mentionable_id"
    t.index ["user_id"], name: "index_tweet_mentionings_on_user_id"
  end

  create_table "tweet_replies", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "root_id"
    t.bigint "tweet_id"
    t.bigint "previous_id"
    t.text "content"
    t.integer "replies_count", default: 0
    t.integer "likes_count", default: 0
    t.integer "retweets_count", default: 0
    t.json "photos"
    t.string "video"
    t.string "widths", default: ""
    t.string "heights", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "deleted"
    t.index ["previous_id"], name: "index_tweet_replies_on_previous_id"
    t.index ["root_id"], name: "index_tweet_replies_on_root_id"
    t.index ["tweet_id"], name: "index_tweet_replies_on_tweet_id"
    t.index ["user_id"], name: "index_tweet_replies_on_user_id"
  end

  create_table "tweet_taggings", force: :cascade do |t|
    t.bigint "hashtag_id"
    t.string "taggable_type"
    t.bigint "taggable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hashtag_id"], name: "index_tweet_taggings_on_hashtag_id"
    t.index ["taggable_type", "taggable_id"], name: "index_tweet_taggings_on_taggable_type_and_taggable_id"
  end

  create_table "user_followings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "follower_id"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_id", "status"], name: "followings_follower_id_status"
    t.index ["follower_id"], name: "index_user_followings_on_follower_id"
    t.index ["user_id", "follower_id"], name: "followings_user_id_follower_id"
    t.index ["user_id", "status"], name: "followings_user_id_status"
    t.index ["user_id"], name: "index_user_followings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "slug"
    t.string "username"
    t.string "profilename"
    t.date "birthday"
    t.integer "birthday_visibility", default: 0
    t.string "avatar"
    t.string "cover"
    t.string "country"
    t.string "language", default: "en"
    t.string "theme", default: "blue"
    t.text "introduction"
    t.boolean "banned", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
