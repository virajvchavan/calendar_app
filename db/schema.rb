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

ActiveRecord::Schema.define(version: 2020_03_17_153430) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calendars", force: :cascade do |t|
    t.string "g_id", null: false
    t.string "summary"
    t.string "timezone"
    t.string "bg_color"
    t.string "fg_color"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "google_sync_token"
    t.index ["user_id", "g_id"], name: "index_calendars_on_user_id_and_g_id", unique: true
    t.index ["user_id"], name: "index_calendars_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "g_id", null: false
    t.string "summary"
    t.text "description"
    t.string "location"
    t.string "status"
    t.string "html_link"
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean "all_day_event"
    t.bigint "calendar_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["calendar_id"], name: "index_events_on_calendar_id"
  end

  create_table "tokens", force: :cascade do |t|
    t.integer "user_id"
    t.string "access_token"
    t.string "refresh_token"
    t.integer "expires_at"
    t.string "provider"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "picture_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "google_sync_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
  end

  add_foreign_key "calendars", "users"
  add_foreign_key "events", "calendars"
end
