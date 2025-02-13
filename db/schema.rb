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

ActiveRecord::Schema[8.0].define(version: 2025_02_13_164134) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.bigint "sector_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sector_id"], name: "index_employees_on_sector_id"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "sectors", force: :cascade do |t|
    t.string "name"
    t.bigint "unit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id"], name: "index_sectors_on_unit_id"
  end

  create_table "units", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.bigint "unit_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unit_id"], name: "index_users_on_unit_id"
  end

  create_table "visitors", force: :cascade do |t|
    t.string "cpf"
    t.string "name"
    t.string "rg"
    t.string "phone"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "visits", force: :cascade do |t|
    t.bigint "visitor_id", null: false
    t.bigint "sector_id", null: false
    t.bigint "employee_id", null: false
    t.datetime "visit_time"
    t.bigint "unit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "completed_at"
    t.datetime "confirmed_at"
    t.index ["employee_id"], name: "index_visits_on_employee_id"
    t.index ["sector_id"], name: "index_visits_on_sector_id"
    t.index ["unit_id"], name: "index_visits_on_unit_id"
    t.index ["visitor_id"], name: "index_visits_on_visitor_id"
  end

  add_foreign_key "employees", "sectors"
  add_foreign_key "employees", "users"
  add_foreign_key "sectors", "units"
  add_foreign_key "users", "units"
  add_foreign_key "visits", "employees"
  add_foreign_key "visits", "sectors"
  add_foreign_key "visits", "units"
  add_foreign_key "visits", "visitors"
end
