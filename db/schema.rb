# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171018152920) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"
  enable_extension "citext"

  create_table "item_sessions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "checked_out_at"
    t.datetime "checked_in_at"
    t.uuid "item_id"
    t.decimal "usage", precision: 9, scale: 3
    t.citext "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["checked_in_at"], name: "index_item_sessions_on_checked_in_at"
    t.index ["item_id"], name: "index_item_sessions_on_item_id"
  end

  create_table "items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "sku_id"
    t.string "code"
    t.decimal "amount", precision: 12, scale: 6
    t.citext "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "details"
    t.index ["code"], name: "index_items_on_code", unique: true
    t.index ["sku_id"], name: "index_items_on_sku_id"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "skus", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_skus_on_name"
    t.index ["type"], name: "index_skus_on_type"
  end

  add_foreign_key "item_sessions", "items"
  add_foreign_key "items", "skus"
end
