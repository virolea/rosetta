module Rosetta
  module Pluralization
    class BaseOperator
      def initialize(value:, threshold:)
        @value = value
        @threshold = threshold
      end

      def check
        raise NotImplementedError
      end
    end
  end
end
