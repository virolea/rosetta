module Rosetta
  module Translated
    extend ActiveSupport::Concern

    class_methods do
      def translated_in_all_locales
        Locale.all.each do |locale|
          translated_in(locale)
        end

        Locale.register_class_for_translation(self)
      end

      def translated_in(locale)
        has_one :"#{locale.code}_translation", -> { where(target_locale: locale) }, class_name: "Rosetta::Translation", foreign_key: :from_id, dependent: :destroy
        has_one :"#{locale.code}_translated_version", through: :"#{locale.code}_translation", source: :to

        scope :missing_translation, ->(locale) { where.missing(:"#{locale.code}_translation") }
        scope :with_translated_version, ->(locale) { includes(:"#{locale.code}_translated_version") }

        define_method("content_#{locale.code}") do
          if translation_changes[locale.code]
            translation_changes[locale.code].content
          else
            public_send(:"#{locale.code}_translated_version")&.content
          end
        end

        define_method("content_#{locale.code}=") do |localized_content|
          translation_changes[locale.code] = if localized_content.blank?
            Rosetta::Translated::Delete.new(self, locale)
          else
            Rosetta::Translated::Create.new(self, locale, localized_content)
          end
        end

        after_save { translation_changes[locale.code]&.save }
      end
    end

    def content_in(locale)
      public_send("content_#{locale.code}")
    end

    def translation_changes
      @translation_changes ||= {}
    end

    def reload(*)
      super.tap { @translation_changes = nil }
    end
  end
end
