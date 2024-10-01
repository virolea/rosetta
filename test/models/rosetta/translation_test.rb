require "test_helper"

module Rosetta
  class TranslationTest < ActiveSupport::TestCase
    test "Adding the same translation twice raises" do
      locale = rosetta_locales(:french)

      assert_raises ActiveRecord::RecordNotUnique do
        Rosetta::Translation.create(target_locale: locale, from: rosetta_text_entries(:hello), to: rosetta_text_entries(:bonjour))
      end
    end
  end
end
