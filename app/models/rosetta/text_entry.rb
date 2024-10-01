module Rosetta
  class TextEntry < ApplicationRecord
    include Translated

    belongs_to :locale

    translated_in_all_locales

    def self.create_later(content)
      AutodiscoveryJob.perform_later(content)
    end

    def purge
      destroy
    rescue ActiveRecord::InvalidForeignKey
    end

    def purge_later
      PurgeJob.perform_later(self)
    end
  end
end
