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

ActiveRecord::Schema.define(version: 20150206043447) do

  create_table "feed_entries", force: :cascade do |t|
    t.integer  "feed_id"
    t.string   "title"
    t.binary   "content"
    t.datetime "posting_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "entry"
    t.string   "url"
  end

  add_index "feed_entries", ["feed_id", "entry"], name: "index_feed_entries_on_feed_id_and_entry", unique: true
  add_index "feed_entries", ["posting_date"], name: "index_feed_entries_on_posting_date"

  create_table "feeds", force: :cascade do |t|
    t.string   "url"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "website"
    t.integer  "crawl_errors",       default: 0
    t.integer  "feed_entries_count", default: 0
  end

  add_index "feeds", ["url"], name: "index_feeds_on_url", unique: true

  create_table "user_subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "feed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_subscriptions", ["user_id", "feed_id"], name: "index_user_subscriptions_on_user_id_and_feed_id", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "viewed", force: :cascade do |t|
    t.integer "user_id"
    t.integer "feed_entry_id"
  end

  add_index "viewed", ["user_id", "feed_entry_id"], name: "index_viewed_on_user_id_and_feed_entry_id", unique: true

end
