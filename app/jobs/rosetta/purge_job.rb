module Rosetta
  class PurgeJob < Rosetta::ApplicationJob
    queue_as { Rosetta.config.queues[:purge] }

    discard_on ActiveRecord::RecordNotFound

    def perform(text_entry)
      text_entry.purge
    end
  end
end
