require "test_helper"

class Rosetta::TranslatedTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  test "setting a new translation" do
    text_entry = rosetta_text_entries(:goodbye)
    text_entry.update(content_fr: "au revoir")
    text_entry.reload

    assert_equal "au revoir", text_entry.content_fr
    assert_not_nil text_entry.fr_translation
  end

  test "setting a new translation to an existing entry does not create a new entry" do
    text_entry = Rosetta::TextEntry.create(content: "good morning", locale: rosetta_locales(:english))

    assert_no_difference "Rosetta::TextEntry.count" do
      text_entry.update(content_fr: "bonjour")
    end

    assert_equal "bonjour", text_entry.reload.content_fr
  end

  test "setting a translation to blank removes the translation" do
    text_entry = rosetta_text_entries(:hello)

    text_entry.update(content_fr: "")
    text_entry.reload

    assert_nil text_entry.content_fr
    assert_nil text_entry.fr_translation
  end
end
