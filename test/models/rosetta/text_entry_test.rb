require "test_helper"

class Rosetta::TextEntryTest < ActiveSupport::TestCase
  test "purge does nothing when a translation exists" do
    assert_no_difference -> { Rosetta::TextEntry.count } do
      rosetta_text_entries(:bonjour).purge
    end
  end
end
