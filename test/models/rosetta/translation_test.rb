require "test_helper"

module Rosetta
  class TranslationTest < ActiveSupport::TestCase
    test "Adding the same translation twice raises" do
      locale = Rosetta::Locale.create(name: "French", code: "fr")
      key = Rosetta::TranslationKey.create(value: "test")
      Rosetta::Translation.create(locale: locale, translation_key: key, value: "test")

      assert_raises ActiveRecord::RecordNotUnique do
        Rosetta::Translation.create(locale: locale, translation_key: key, value: "test")
      end
    end
  end
end
