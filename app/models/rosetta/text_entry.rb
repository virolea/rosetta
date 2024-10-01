module Rosetta
  class TextEntry < ApplicationRecord
    include Translated

    translate_in_all_locales

    belongs_to :locale

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
