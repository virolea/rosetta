module Rosetta
  class TranslationKey < ApplicationRecord
    include Translated

    translated_in_all_locales

    def self.create_later(value)
      AutodiscoveryJob.perform_later(value)
    end
  end
end
