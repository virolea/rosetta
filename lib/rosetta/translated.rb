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

        define_method("value_#{locale.code}") do
          if translation_changes[locale.code]
            translation_changes[locale.code].value
          else
            public_send(:"#{locale.code}_translation")&.value
          end
        end

        define_method("value_#{locale.code}=") do |locale_value|
          translation_changes[locale.code] = if locale_value.blank?
            Rosetta::Translated::Delete.new(self, locale)
          else
            Rosetta::Translated::Create.new(self, locale, locale_value)
          end
        end

        after_save { translation_changes[locale.code]&.save }
      end
    end

    def translation_changes
      @translation_changes ||= {}
    end

    def reload(*)
      super.tap { @translation_changes = nil }
    end
  end
end
