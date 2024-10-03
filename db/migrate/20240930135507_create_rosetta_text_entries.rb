class CreateRosettaTextEntries < ActiveRecord::Migration[7.2]
  def change
    create_table :rosetta_text_entries do |t|
      t.text :content, null: false
      t.references :locale, null: false

      t.timestamps

      t.index :content
      t.index [ :locale_id, :content ], unique: true
      t.foreign_key :rosetta_locales, column: :locale_id
    end
  end
end
