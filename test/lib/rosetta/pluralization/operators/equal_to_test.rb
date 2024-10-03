require "test_helper"

class Rosetta::Pluralization::Operators::EqualToTest < ActiveSupport::TestCase
  include PluralizationOperatorHelpers

  test "checks correct counts" do
    assert operator_class.new(value: 1, threshold: 1).check
    assert_not operator_class.new(value: 2, threshold: 1).check
    assert_not operator_class.new(value: 0, threshold: 1).check
  end
end
