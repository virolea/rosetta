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

ActiveRecord::Schema.define(version: 2024_08_30_123523) do
  create_table "rosetta_locales", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.boolean "published", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index [ "code" ], name: "index_rosetta_locales_on_code", unique: true
  end

  create_table "rosetta_translation_keys", force: :cascade do |t|
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index [ "value" ], name: "index_rosetta_translation_keys_on_value", unique: true
  end

  create_table "rosetta_translations", force: :cascade do |t|
    t.text "value"
    t.integer "locale_id", null: false
    t.integer "translation_key_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index [ "locale_id", "translation_key_id" ], name: "index_rosetta_translations_on_locale_id_and_translation_key_id", unique: true
    t.index [ "locale_id" ], name: "index_rosetta_translations_on_locale_id"
    t.index [ "translation_key_id" ], name: "index_rosetta_translations_on_translation_key_id"
  end

  add_foreign_key "rosetta_translations", "rosetta_locales", column: "locale_id"
  add_foreign_key "rosetta_translations", "rosetta_translation_keys", column: "translation_key_id"
end
