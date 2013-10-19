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

ActiveRecord::Schema.define(version: 20131019184906) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "railscasts", force: true do |t|
    t.string   "url"
    t.string   "name"
    t.text     "description"
    t.boolean  "railscasts",  default: false
    t.boolean  "pro",         default: false
    t.boolean  "revised",     default: false
    t.string   "duration"
    t.integer  "position"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "treasure_votes", force: true do |t|
    t.integer  "value"
    t.integer  "user_id"
    t.integer  "treasure_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "treasure_votes", ["treasure_id"], name: "index_treasure_votes_on_treasure_id", using: :btree
  add_index "treasure_votes", ["user_id"], name: "index_treasure_votes_on_user_id", using: :btree

  create_table "treasures", force: true do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "railscast_id"
    t.time     "time"
  end

  add_index "treasures", ["railscast_id"], name: "index_treasures_on_railscast_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "guest"
    t.boolean  "admin"
  end

end
