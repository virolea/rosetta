class AddDefaultToRosettaLocales < ActiveRecord::Migration[7.2]
  def change
    add_column :rosetta_locales, :default, :boolean, default: false
  end
end
