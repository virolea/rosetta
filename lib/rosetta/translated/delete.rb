module Rosetta
  class Translated::Delete
    attr_reader :content

    def initialize(record, locale)
      @record = record
      @locale = locale
      @content = nil
    end

    def save
      @record.public_send(:"#{@locale.code}_translation=", nil)
    end
  end
end
