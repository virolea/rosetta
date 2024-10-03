require "test_helper"

module Rosetta
  class AutodiscoveryJobTest < ActiveJob::TestCase
    test "creates a new key" do
      assert_difference "Rosetta::TextEntry.count", 1 do
        Rosetta::AutodiscoveryJob.perform_now("Test creation from job")
      end
    end

    test "ignores duplicate keys" do
      TextEntry.create(content: "duplicate", locale: rosetta_locales(:english))

      perform_enqueued_jobs do
        assert_nothing_raised do
          Rosetta::AutodiscoveryJob.perform_later("duplicate")
        end
      end
    end
  end
end
