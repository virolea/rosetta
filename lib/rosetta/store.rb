module Rosetta
  class Store
    class_attribute :locale_stores, default: Concurrent::Map.new

    attr_reader :locale, :cache_expiration_timestamp

    def self.for_locale(locale)
      store = locale_stores[locale.code.to_sym] ||= new(locale)
      store.touch!(locale.updated_at)
      store
    end

    def initialize(locale)
      @locale = locale
      @cache_expiration_timestamp = @locale.updated_at
    end

    def lookup(content)
      if translations.has_key?(content)
        translations[content]
      else
        TextEntry.create_later(content)
        # Set the key in the translations store to locate it
        # once only.
        translations[content] = nil
      end
    end

    def reload!
      @translations = nil
    end

    def touch!(timestamp)
      return if @cache_expiration_timestamp == timestamp

      @cache_expiration_timestamp = timestamp
      reload!
    end

    def translations
      @translations ||= load_translations
    end

    private

    def load_translations
      loaded_translations = TextEntry
        .with_translated_version(@locale)
        .where(locale: Rosetta::Locale.default_locale)
        .map do |text_entry|
        [ text_entry.content, text_entry.public_send(:"#{@locale.code}_translated_version")&.content ]
      end.to_h

      Concurrent::Hash.new.merge(loaded_translations)
    end
  end
end
