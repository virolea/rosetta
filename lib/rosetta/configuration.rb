module Rosetta
  class Configuration
    attr_reader :default_locale
    attr_accessor :parent_controller_class
    attr_accessor :queues

    DefaultLocale = Struct.new(:name, :code)

    def initialize
      set_default_locale(name: "English", code: "en")
      @parent_controller_class = "ActionController::Base"
      @queues = {}
    end

    def set_default_locale(name:, code:)
      @default_locale = DefaultLocale.new(name, code)
    end
  end
end
