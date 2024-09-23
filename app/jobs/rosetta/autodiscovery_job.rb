module Rosetta
  class AutodiscoveryJob < Rosetta::ApplicationJob
    queue_as { Rosetta.config.queues[:autodiscovery] }

    discard_on ActiveRecord::RecordNotUnique

    def perform(value)
      TranslationKey.create!(value: value)
    end
  end
end
