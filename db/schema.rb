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

ActiveRecord::Schema[8.0].define(version: 2025_05_08_182810) do
  create_table "gas_stations", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.decimal "price_per_liter", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "refuelings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "gas_station_id", null: false
    t.decimal "liters", precision: 10, scale: 2, null: false
    t.decimal "total_cost", precision: 10, scale: 2, null: false
    t.decimal "discount", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gas_station_id"], name: "index_refuelings_on_gas_station_id"
    t.index ["user_id"], name: "index_refuelings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "balance", precision: 10, scale: 2, default: "0.0"
    t.string "jti", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "refuelings", "gas_stations"
  add_foreign_key "refuelings", "users"
end
