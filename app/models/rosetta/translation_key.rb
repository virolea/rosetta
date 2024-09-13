module Rosetta
  class TranslationKey < ApplicationRecord
    has_many :translations, dependent: :destroy
    has_many :locales

    class << self
      def all_in_locale(locale)
        select("rosetta_translation_keys.*, rosetta_translations.id as translation_id, rosetta_translations.value as translation_value")
          .joins("LEFT JOIN rosetta_translations ON rosetta_translations.translation_key_id = rosetta_translation_keys.id AND rosetta_translations.locale_id = #{locale.id}")
      end

      def with_missing_translation_in_locale(locale)
        all_in_locale(locale)
          .where("rosetta_translations.id IS NULL")
      end
    end
  end
end
