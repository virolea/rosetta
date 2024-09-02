class CreateRosettaLocales < ActiveRecord::Migration[7.2]
  def change
    create_table :rosetta_locales do |t|
      t.string :name
      t.string :code
      t.boolean :published, default: false

      t.timestamps
    end
    add_index :rosetta_locales, :code, unique: true
  end
end
