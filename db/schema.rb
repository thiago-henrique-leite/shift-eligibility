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

ActiveRecord::Schema[7.1].define(version: 2024_09_03_025114) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "Document", force: :cascade do |t|
    t.text "name", null: false
    t.boolean "is_active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "DocumentWorker", force: :cascade do |t|
    t.bigint "worker_id", null: false
    t.bigint "document_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_DocumentWorker_on_document_id"
    t.index ["worker_id"], name: "index_DocumentWorker_on_worker_id"
  end

  create_table "Facility", force: :cascade do |t|
    t.text "name", null: false
    t.boolean "is_active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "FacilityRequirement", force: :cascade do |t|
    t.bigint "facility_id", null: false
    t.bigint "document_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_FacilityRequirement_on_document_id"
    t.index ["facility_id"], name: "index_FacilityRequirement_on_facility_id"
  end

  create_table "Shift", force: :cascade do |t|
    t.datetime "start", precision: 3, null: false
    t.datetime "ends_at", precision: 3, null: false
    t.string "profession", null: false
    t.boolean "is_deleted", default: false, null: false
    t.bigint "facility_id", null: false
    t.bigint "worker_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_Shift_on_facility_id"
    t.index ["worker_id"], name: "index_Shift_on_worker_id"
  end

  create_table "Worker", force: :cascade do |t|
    t.text "name", null: false
    t.boolean "is_active", default: false, null: false
    t.string "profession", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "DocumentWorker", "Document", column: "document_id", on_update: :cascade, on_delete: :restrict
  add_foreign_key "DocumentWorker", "Worker", column: "worker_id", on_update: :cascade, on_delete: :restrict
  add_foreign_key "FacilityRequirement", "Document", column: "document_id", on_update: :cascade, on_delete: :restrict
  add_foreign_key "FacilityRequirement", "Facility", column: "facility_id", on_update: :cascade, on_delete: :restrict
  add_foreign_key "Shift", "Facility", column: "facility_id", on_update: :cascade, on_delete: :restrict
  add_foreign_key "Shift", "Worker", column: "worker_id", on_update: :cascade, on_delete: :nullify
end
