# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_22_114606) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chats", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "request_id", null: false
    t.bigint "volunteer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["request_id"], name: "index_chats_on_request_id"
    t.index ["user_id"], name: "index_chats_on_user_id"
    t.index ["volunteer_id"], name: "index_chats_on_volunteer_id"
  end

  create_table "requests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.string "request_type"
    t.string "description"
    t.string "location"
    t.boolean "status", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
  end

  create_table "volunteers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "request_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["request_id"], name: "index_volunteers_on_request_id"
    t.index ["user_id"], name: "index_volunteers_on_user_id"
  end

  add_foreign_key "chats", "requests"
  add_foreign_key "chats", "users"
  add_foreign_key "chats", "volunteers"
  add_foreign_key "requests", "users"
  add_foreign_key "volunteers", "requests"
  add_foreign_key "volunteers", "users"
end
