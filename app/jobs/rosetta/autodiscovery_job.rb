module Rosetta
  class AutodiscoveryJob < Rosetta::ApplicationJob
    queue_as :default

    discard_on ActiveRecord::RecordNotUnique

    def perform(value)
      TranslationKey.create!(value: value)
    end
  end
end
