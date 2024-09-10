class CreateRosettaTranslationKeys < ActiveRecord::Migration[7.2]
  def change
    create_table :rosetta_translation_keys do |t|
      t.text :value

      t.timestamps
    end
    add_index :rosetta_translation_keys, :value, unique: true
  end
end
