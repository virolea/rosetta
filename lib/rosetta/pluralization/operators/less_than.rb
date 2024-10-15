module Rosetta
  module Pluralization
    module Operators
      class LessThan < BaseOperator
        def check
          @value < @threshold
        end
      end
    end
  end
end
