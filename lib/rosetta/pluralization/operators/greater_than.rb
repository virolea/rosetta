module Rosetta
  module Pluralization
    module Operators
      class GreaterThan < BaseOperator
        def check
          @value > @threshold
        end
      end
    end
  end
end
