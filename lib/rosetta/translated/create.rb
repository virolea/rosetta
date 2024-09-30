module Rosetta
  class Translated::Create
    attr_reader :value

    def initialize(record, locale, value)
      @record = record
      @locale = locale
      @value = value
    end

    def save
      translation.value = @value
      @record.public_send(:"#{@locale.code}_translation=", translation)
    end

    def translation
      @translation ||= @record.public_send(:"build_#{@locale.code}_translation")
    end
  end
end
