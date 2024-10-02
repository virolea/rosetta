class DropTranslationKeys < ActiveRecord::Migration[7.2]
  def change
    drop_table :rosetta_translation_keys
  end
end
