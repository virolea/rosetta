module Rosetta
  class Store
    class_attribute :locale_stores, default: Concurrent::Map.new

    attr_reader :locale

    def self.for_locale(locale)
      locale_stores[locale.code.to_sym] ||= new(locale)
    end

    def initialize(locale)
      @locale = locale
      @autodiscovery_queue = Queue.new

      start_key_autodiscovery!
    end

    def lookup(key_value)
      if translations.has_key?(key_value)
        translations[key_value]
      else
        @autodiscovery_queue << key_value
        # Set the key in the translations store to locate it
        # once only.
        translations[key_value] = nil
      end
    end

    def reload!
      @translations = nil
    end

    def translations
      @translations ||= load_translations
    end

    private

    def load_translations
      loaded_translations = TranslationKey
        .all_in_locale(locale)
        .map do |translation_key|
        [ translation_key.value, translation_key.translation_value ]
      end.to_h

      Concurrent::Hash.new.merge(loaded_translations)
    end

    def start_key_autodiscovery!
      Thread.new do
        Thread.current.name = "Rosetta #{locale.code} store thread"

        loop do
          key_value = @autodiscovery_queue.pop

          unless TranslationKey.exists?(value: key_value)
            TranslationKey.create!(value: key_value)
          end
        end
      end
    end
  end
end
