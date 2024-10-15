module Rosetta
  module Pluralization
    module Operators
      class EqualTo < BaseOperator
        def check
          @value == @threshold
        end
      end
    end
  end
end