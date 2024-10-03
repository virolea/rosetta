module Rosetta
  class Translated::Create
    attr_reader :content

    def initialize(record, locale, content)
      @record = record
      @locale = locale
      @content = content
    end

    def save
      @record.public_send(:"#{@locale.code}_translation=", translation)
    end

    def translated_version
      @translated_version ||= find_or_build_translated_version
    end

    def translation
      @record.public_send(:"build_#{@locale.code}_translation", to: translated_version)
    end

    private

    def find_or_build_translated_version
      find_translated_version || build_translated_version
    end

    def find_translated_version
      TextEntry.find_by(locale: @locale, content: @content)
    end

    def build_translated_version
      TextEntry.new(locale: @locale, content: @content)
    end
  end
end
