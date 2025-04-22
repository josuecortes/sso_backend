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

ActiveRecord::Schema[8.0].define(version: 2025_04_21_021344) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "location_types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organizational_unit_types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organizational_units", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "sigla"
    t.boolean "active"
    t.bigint "parent_id"
    t.bigint "organizational_unit_type_id", null: false
    t.bigint "location_type_id", null: false
    t.jsonb "custom_fields"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_type_id"], name: "index_organizational_units_on_location_type_id"
    t.index ["organizational_unit_type_id"], name: "index_organizational_units_on_organizational_unit_type_id"
    t.index ["parent_id"], name: "index_organizational_units_on_parent_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_role_assignments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
    t.boolean "active"
    t.bigint "assigned_by_id"
    t.datetime "assigned_at"
    t.datetime "removed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assigned_by_id"], name: "index_user_role_assignments_on_assigned_by_id"
    t.index ["role_id"], name: "index_user_role_assignments_on_role_id"
    t.index ["user_id"], name: "index_user_role_assignments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti"
    t.string "name"
    t.date "birth_date"
    t.string "phone"
    t.string "whatsapp"
    t.string "cpf"
    t.string "matricula"
    t.boolean "active", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "organizational_units", "location_types"
  add_foreign_key "organizational_units", "organizational_unit_types"
  add_foreign_key "organizational_units", "organizational_units", column: "parent_id"
  add_foreign_key "user_role_assignments", "roles"
  add_foreign_key "user_role_assignments", "users"
  add_foreign_key "user_role_assignments", "users", column: "assigned_by_id"
end
