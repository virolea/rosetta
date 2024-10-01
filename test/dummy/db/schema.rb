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

ActiveRecord::Schema.define(version: 2024_09_30_135810) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "rosetta_locales", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.boolean "published", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "default", default: false
    t.index ["code"], name: "index_rosetta_locales_on_code", unique: true
  end

  create_table "rosetta_text_entries", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "locale_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content"], name: "index_rosetta_text_entries_on_content"
    t.index ["locale_id", "content"], name: "index_rosetta_text_entries_on_locale_id_and_content", unique: true
    t.index ["locale_id"], name: "index_rosetta_text_entries_on_locale_id"
  end

  create_table "rosetta_translation_keys", force: :cascade do |t|
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["value"], name: "index_rosetta_translation_keys_on_value", unique: true
  end

  create_table "rosetta_translations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "target_locale_id", null: false
    t.bigint "from_id", null: false
    t.bigint "to_id", null: false
    t.index ["from_id"], name: "index_rosetta_translations_on_from_id"
    t.index ["target_locale_id", "from_id", "to_id"], name: "rosetta_translations_uniqueness", unique: true
    t.index ["target_locale_id"], name: "index_rosetta_translations_on_target_locale_id"
    t.index ["to_id"], name: "index_rosetta_translations_on_to_id"
  end

  add_foreign_key "rosetta_text_entries", "rosetta_locales", column: "locale_id"
  add_foreign_key "rosetta_translations", "rosetta_locales", column: "target_locale_id"
  add_foreign_key "rosetta_translations", "rosetta_text_entries", column: "from_id"
  add_foreign_key "rosetta_translations", "rosetta_text_entries", column: "to_id"
end
