module Rosetta
  class PluralizationRule < ApplicationRecord
    OPERATORS = {
      less_than_or_equal_to: Pluralization::Operators::LessThanOrEqualTo,
      less_than: Pluralization::Operators::LessThan,
      equal_to: Pluralization::Operators::EqualTo,
      greater_than_or_equal_to: Pluralization::Operators::GreaterThanOrEqualTo,
      greater_than: Pluralization::Operators::GreaterThan
    }.with_indifferent_access

    belongs_to :locale

    validates :name, :operator, :threshold, presence: true
    validates :threshold, numericality: { greater_than_or_equal_to: 0 }
    validates :operator, inclusion: { in: OPERATORS.keys }

    def activated?(test_value)
      OPERATORS[operator].new(value: test_value, threshold: threshold).check
    end
  end
end
