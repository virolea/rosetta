module Rosetta
  module Translated
    extend ActiveSupport::Concern

    included do
      has_many :translations, dependent: :destroy
    end

    class_methods do
      def translated_in_all_locales
        Locale.all.each do |locale|
          translated_in(locale)
        end

        Locale.register_class_for_translation(self)
      end

      def translated_in(locale)
        has_one :"#{locale.code}_translation", -> { where(locale_id: locale.id) }, class_name: "Translation", dependent: :destroy

        scope :with_translation, ->(locale) { includes(:"#{locale.code}_translation") }
        scope :with_missing_translation, ->(locale) { with_translation(locale).where.missing(:"#{locale.code}_translation") }
      end
    end

    def translation_in(locale)
      public_send(:"#{locale.code}_translation")
    end
  end
end
