class CreateRosettaTranslations < ActiveRecord::Migration[7.2]
  def change
    create_table :rosetta_translations do |t|
      t.text :value
      t.references :locale, null: false, foreign_key: true
      t.references :translation_key, null: false, foreign_key: true

      t.timestamps

      t.index [ :locale_id, :translation_key_id ], unique: true
      t.foreign_key :rosetta_locales, column: :locale_id
      t.foreign_key :rosetta_translation_keys, column: :translation_key_id
    end
  end
end
