module Rosetta
  class ApplicationController < Rosetta.config.parent_controller_class.constantize
    include Pagy::Backend
  end
end
