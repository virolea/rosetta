module Rosetta
  class Translated::Delete
    attr_reader :value

    def initialize(record, locale)
      @record = record
      @locale = locale
      @value = nil
    end

    def save
      @record.public_send(:"#{@locale.code}_translation=", nil)
    end
  end
end
