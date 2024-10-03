module Rosetta
  class Translation < ApplicationRecord
    belongs_to :target_locale, class_name: "Rosetta::Locale"
    belongs_to :from, class_name: "Rosetta::TextEntry"
    belongs_to :to, class_name: "Rosetta::TextEntry"

    after_destroy_commit :purge_orphaned_text_entries_later

    private

    def purge_orphaned_text_entries_later
      to.purge_later
    end
  end
end
