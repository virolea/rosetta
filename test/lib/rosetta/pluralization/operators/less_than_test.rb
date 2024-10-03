require "test_helper"

class Rosetta::Pluralization::Operators::LessThanTest < ActiveSupport::TestCase
  include PluralizationOperatorHelpers

  test "checks correct counts" do
    assert operator_class.new(value: 1, threshold: 2).check
    assert_not operator_class.new(value: 2, threshold: 2).check
    assert_not operator_class.new(value: 5, threshold: 2).check
  end
end
