module Rosetta
  module Pluralization
    module Operators
      class GreaterThanOrEqualTo < BaseOperator
        def check
          @value >= @threshold
        end
      end
    end
  end
end
