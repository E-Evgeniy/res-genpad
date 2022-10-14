# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_10_11_195955) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "result_tests", force: :cascade do |t|
    t.integer "device_id"
    t.string "marker"
    t.datetime "date_test"
    t.string "name_channel_1"
    t.integer "volume_channel_1"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name_channel_2"
    t.string "name_channel_3"
    t.string "name_channel_4"
    t.integer "volume_channel_2"
    t.integer "volume_channel_3"
    t.integer "volume_channel_4"
    t.integer "unit_of_time"
  end

  create_table "tests", force: :cascade do |t|
    t.string "marker"
    t.string "configuration_number"
    t.string "configuration_text"
    t.string "cartridge_type"
    t.string "reagent"
    t.date "production_date"
    t.date "testing_date"
    t.string "conclusion"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "header"
    t.bigint "user_id", null: false
    t.string "fluid"
    t.index ["user_id"], name: "index_tests_on_user_id"
  end

  create_table "tests_devices", force: :cascade do |t|
    t.integer "device_id"
    t.datetime "date_test"
    t.string "sample_barcode"
    t.integer "threshold"
    t.string "result_channel_1"
    t.string "result_channel_2"
    t.string "result_channel_3"
    t.string "result_channel_4"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "marker"
    t.string "name_channel_1"
    t.string "name_channel_2"
    t.string "name_channel_3"
    t.string "name_channel_4"
    t.string "time_channel_1"
    t.string "time_channel_2"
    t.string "time_channel_3"
    t.string "time_channel_4"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "tests", "users"
end
