module Rosetta
  module Pluralization
    module Operators
      class LessThanOrEqualTo < BaseOperator
        def check
          @value <= @threshold
        end
      end
    end
  end
end
