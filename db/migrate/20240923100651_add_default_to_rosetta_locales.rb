class AddDefaultToRosettaLocales < ActiveRecord::Migration[6.1]
  def change
    add_column :rosetta_locales, :default, :boolean, default: false
  end
end
