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

ActiveRecord::Schema.define(version: 2020_12_08_001250) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "questions", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.integer "round_count", default: 3
    t.integer "status", default: 0, null: false
    t.bigint "host_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["host_id"], name: "index_rooms_on_host_id"
    t.index ["password"], name: "index_rooms_on_password", unique: true
  end

  create_table "rounds", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "question_id"
    t.index ["question_id"], name: "index_rounds_on_question_id"
    t.index ["room_id"], name: "index_rounds_on_room_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "visitor_key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "room_id"
    t.string "name", default: "Player"
    t.index ["room_id"], name: "index_users_on_room_id"
    t.index ["visitor_key"], name: "index_users_on_visitor_key", unique: true
  end

  add_foreign_key "rooms", "users", column: "host_id"
  add_foreign_key "rounds", "questions"
  add_foreign_key "rounds", "rooms"
  add_foreign_key "users", "rooms"
end
