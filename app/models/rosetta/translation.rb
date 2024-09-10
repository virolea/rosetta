module Rosetta
  class Translation < ApplicationRecord
    belongs_to :locale, class_name: "Rosetta::Locale", inverse_of: :translations
    belongs_to :translation_key, class_name: "Rosetta::TranslationKey", inverse_of: :translations
  end
end
