require "test_helper"

class Rosetta::TranslatedTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  test "setting a new translation" do
    translation_key = rosetta_translation_keys(:goodbye)
    translation_key.update(value_fr: "au revoir")
    translation_key.reload

    assert_equal "au revoir", translation_key.value_fr
    assert_not_nil translation_key.fr_translation
  end

  test "setting a translation to blank removes the translation" do
    translation_key = rosetta_translation_keys(:hello)

    translation_key.update(value_fr: "")
    translation_key.reload

    assert_nil translation_key.value_fr
    assert_nil translation_key.fr_translation
  end

  test "setting a translation without saving returns the updated translation" do
    translation_key = rosetta_translation_keys(:hello)
    translation_key.value_fr = "salut"

    assert_equal "salut", translation_key.value_fr
    assert_equal "bonjour", translation_key.reload.value_fr
  end
end
