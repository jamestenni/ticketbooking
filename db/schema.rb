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

ActiveRecord::Schema.define(version: 2021_12_10_144657) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "chairs", force: :cascade do |t|
    t.string "row"
    t.integer "column"
    t.integer "chair_type"
    t.integer "theater_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["theater_id"], name: "index_chairs_on_theater_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "ticket_id", null: false
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ticket_id"], name: "index_inventories_on_ticket_id"
    t.index ["user_id"], name: "index_inventories_on_user_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "name"
    t.integer "movie_type"
    t.text "description"
    t.integer "duration"
    t.date "date_in"
    t.date "date_out"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "orderline_items", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "ticket_id", null: false
    t.float "price"
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_orderline_items_on_order_id"
    t.index ["ticket_id"], name: "index_orderline_items_on_ticket_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "datetime_place"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "theaters", force: :cascade do |t|
    t.string "name"
    t.integer "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "chair_id", null: false
    t.integer "timetable_id", null: false
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chair_id"], name: "index_tickets_on_chair_id"
    t.index ["timetable_id"], name: "index_tickets_on_timetable_id"
  end

  create_table "timetables", force: :cascade do |t|
    t.datetime "datetime_start"
    t.integer "movie_id", null: false
    t.integer "theater_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_timetables_on_movie_id"
    t.index ["theater_id"], name: "index_timetables_on_theater_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.date "birthdate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "chairs", "theaters"
  add_foreign_key "inventories", "tickets"
  add_foreign_key "inventories", "users"
  add_foreign_key "orderline_items", "orders"
  add_foreign_key "orderline_items", "tickets"
  add_foreign_key "orders", "users"
  add_foreign_key "tickets", "chairs"
  add_foreign_key "tickets", "timetables"
  add_foreign_key "timetables", "movies"
  add_foreign_key "timetables", "theaters"
end
