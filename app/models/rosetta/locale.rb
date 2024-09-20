module Rosetta
  class Locale < ApplicationRecord
    class_attribute :registered_classes_for_translations, default: []

    CODE_FORMAT = /\A[a-zA-Z]+(-[a-zA-Z]+)?\z/

    validates :name, :code, presence: true
    validates :code, uniqueness: true
    validates :code, format: { with: CODE_FORMAT, message: "must only contain letters separated by an optional dash" }

    has_many :text_entries, dependent: :destroy
    after_create_commit :notify_translated_models
    has_many :pluralization_rules, dependent: :destroy

    class << self
      def available_locales
        all
      end

      def build_as_default(params)
        new(params.merge(default: true))
      end

      def default_locale
        @default_locale ||= find_by(default: true)
      end

      def default_locale=(locale)
        @default_locale = locale
      end
      def register_class_for_translation(klass)
        registered_classes_for_translations << klass
      end
    end

    def notify_translated_models
      registered_classes_for_translations.each { |klass| klass.translated_in(self) }
    end
  end
end
