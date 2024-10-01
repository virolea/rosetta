module Rosetta
  class AutodiscoveryJob < Rosetta::ApplicationJob
    queue_as { Rosetta.config.queues[:autodiscovery] }

    discard_on ActiveRecord::RecordNotUnique

    def perform(content)
      TextEntry.create!(content: content, locale: Locale.default_locale)
    end
  end
end
