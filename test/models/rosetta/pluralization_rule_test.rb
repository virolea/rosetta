require "test_helper"

module Rosetta
  class PluralizationRuleTest < ActiveSupport::TestCase
    setup do
      @rule = rosetta_pluralization_rules(:french_less_than_or_equal_to_one)
    end

    test "valid" do
      assert @rule.valid?
    end

    %i[name operator threshold].each do |attribute|
      test "invalid without #{attribute}" do
        @rule.public_send("#{attribute}=", nil)
        assert_not @rule.valid?
        assert_includes @rule.errors[attribute], "can't be blank"
      end
    end

    test "operator must be included in the list" do
      @rule.operator = "unknown_operator"
      assert_not @rule.valid?
      assert_includes @rule.errors[:operator], "is not included in the list"
    end

    test "value must be positive" do
      @rule.threshold = -1
      assert_not @rule.valid?
      assert_includes @rule.errors[:threshold], "must be greater than or equal to 0"
    end

    test "#activated?" do
      assert @rule.activated?(0)
      assert @rule.activated?(1)
      assert_not @rule.activated?(2)
    end
  end
end
