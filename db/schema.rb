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

ActiveRecord::Schema.define(version: 20140724060415) do

  create_table "tags", force: true do |t|
    t.integer  "user_id"
    t.string   "name",       limit: 255
    t.boolean  "deleted",                default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "todos", force: true do |t|
    t.integer  "user_id",                                null: false
    t.string   "detail",     limit: 255,                 null: false
    t.string   "tag_id",     limit: 255
    t.integer  "priority",               default: 1
    t.date     "end_date"
    t.boolean  "deleted",                default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "todos", ["priority", "deleted"], name: "index_todos_on_priority_and_deleted", using: :btree

  create_table "user_posts_user_todos", id: false, force: true do |t|
    t.integer "user_todo_id", null: false
    t.integer "user_post_id", null: false
  end

  create_table "users", force: true do |t|
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.boolean  "deleted",                default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
