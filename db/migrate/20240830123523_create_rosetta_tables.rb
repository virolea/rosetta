class CreateRosettaTables < ActiveRecord::Migration[6.1]
  def change
    create_table :rosetta_locales do |t|
      t.string :name
      t.string :code
      t.boolean :published, default: false

      t.timestamps

      t.index :code, unique: true
    end

    create_table :rosetta_translation_keys do |t|
      t.text :value

      t.timestamps

      t.index :value, unique: true
    end

    create_table :rosetta_translations do |t|
      t.text :value
      t.references :locale, null: false
      t.references :translation_key, null: false

      t.timestamps

      t.index [ :locale_id, :translation_key_id ], unique: true
      t.foreign_key :rosetta_locales, column: :locale_id
      t.foreign_key :rosetta_translation_keys, column: :translation_key_id
    end
  end
end
