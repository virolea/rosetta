require "test_helper"

module Rosetta
  class TranslationTest < ActiveSupport::TestCase
    test "Adding the same translation twice raises" do
      locale = rosetta_locales(:french)
      key = rosetta_translation_keys(:hello)

      assert_raises ActiveRecord::RecordNotUnique do
        Rosetta::Translation.create(locale: locale, translation_key: key, value: "bonjour x2")
      end
    end
  end
end
