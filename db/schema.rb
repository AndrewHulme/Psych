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

ActiveRecord::Schema.define(version: 2021_01_30_195443) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allowlisted_jwts", force: :cascade do |t|
    t.string "jti", null: false
    t.string "aud"
    t.datetime "exp", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["jti"], name: "index_allowlisted_jwts_on_jti", unique: true
    t.index ["user_id"], name: "index_allowlisted_jwts_on_user_id"
  end

  create_table "answers", force: :cascade do |t|
    t.string "answer", null: false
    t.bigint "user_id", null: false
    t.bigint "round_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["round_id"], name: "index_answers_on_round_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["title"], name: "index_questions_on_title", unique: true
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.integer "round_count", default: 3
    t.integer "status", default: 0, null: false
    t.bigint "host_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "current_round_id"
    t.index ["current_round_id"], name: "index_rooms_on_current_round_id"
    t.index ["host_id"], name: "index_rooms_on_host_id"
    t.index ["password"], name: "index_rooms_on_password", unique: true
  end

  create_table "rounds", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "question_template_id"
    t.string "question"
    t.bigint "subject_id"
    t.integer "status"
    t.index ["question_template_id"], name: "index_rounds_on_question_template_id"
    t.index ["room_id"], name: "index_rounds_on_room_id"
    t.index ["subject_id"], name: "index_rounds_on_subject_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "visitor_key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "room_id"
    t.string "name", default: "Player"
    t.boolean "ready_for_next_round"
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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token"
    t.index ["email"], name: "index_users_on_email"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
    t.index ["room_id"], name: "index_users_on_room_id"
    t.index ["visitor_key"], name: "index_users_on_visitor_key", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "answer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["answer_id"], name: "index_votes_on_answer_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "allowlisted_jwts", "users", on_delete: :cascade
  add_foreign_key "answers", "rounds"
  add_foreign_key "answers", "users"
  add_foreign_key "rooms", "rounds", column: "current_round_id"
  add_foreign_key "rooms", "users", column: "host_id"
  add_foreign_key "rounds", "questions", column: "question_template_id"
  add_foreign_key "rounds", "rooms"
  add_foreign_key "rounds", "users", column: "subject_id"
  add_foreign_key "users", "rooms"
  add_foreign_key "votes", "answers"
  add_foreign_key "votes", "users"
end
