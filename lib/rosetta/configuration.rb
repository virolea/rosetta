module Rosetta
  class Configuration
    attr_reader :default_locale

    DefaultLocale = Struct.new(:name, :code)

    def initialize
      set_default_locale(name: "English", code: "en")
    end

    def set_default_locale(name:, code:)
      @default_locale = DefaultLocale.new(name, code)
    end
  end
end
