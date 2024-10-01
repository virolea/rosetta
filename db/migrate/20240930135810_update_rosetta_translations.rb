class UpdateRosettaTranslations < ActiveRecord::Migration[7.2]
  def change
    change_table :rosetta_translations do |t|
      t.remove :value

      t.references :target_locale, null: false
      t.references :from, null: false
      t.references :to, null: false

      t.foreign_key :rosetta_locales, column: :target_locale_id
      t.foreign_key :rosetta_text_entries, column: :from_id
      t.foreign_key :rosetta_text_entries, column: :to_id

      t.index [ :target_locale_id, :from_id, :to_id ], name: :rosetta_translations_uniqueness, unique: true
    end

    remove_reference :rosetta_translations, :translation_key
    remove_reference :rosetta_translations, :locale
  end
end
