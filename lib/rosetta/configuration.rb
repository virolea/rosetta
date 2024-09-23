module Rosetta
  class Configuration
    attr_accessor :parent_controller_class
    attr_accessor :queues

    def initialize
      @parent_controller_class = "ActionController::Base"
      @queues = {}
    end
  end
end
