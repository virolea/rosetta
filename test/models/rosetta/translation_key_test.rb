require "test_helper"

module Rosetta
  class TranslationKeyTest < ActiveSupport::TestCase
    test "self#all_in_locale returns all keys with or without a corresponding translation" do
      collection = Rosetta::TranslationKey.all_in_locale(rosetta_locales(:french))

      assert_equal collection.map(&:id).sort, [ rosetta_translation_keys(:hello).id, rosetta_translation_keys(:goodbye).id ].sort
      assert_equal collection.map(&:translation_value).compact, [ "bonjour" ]
    end

    test "self#with_missing_translation_in_locale returns only keys without a corresponding translation" do
      collection = Rosetta::TranslationKey.with_missing_translation_in_locale(rosetta_locales(:french))

      assert_equal collection.map(&:id), [ rosetta_translation_keys(:goodbye).id ]
    end
  end
end
