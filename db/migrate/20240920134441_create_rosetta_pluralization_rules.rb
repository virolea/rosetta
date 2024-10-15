class CreateRosettaPluralizationRules < ActiveRecord::Migration[6.1]
  def change
    create_table :rosetta_pluralization_rules do |t|
      t.string :name
      t.string :operator
      t.integer :threshold
      t.references :locale, null: false

      t.timestamps

      t.foreign_key :rosetta_locales, column: :locale_id
    end
  end
end
