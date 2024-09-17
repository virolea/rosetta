module Rosetta
  class TranslationKey < ApplicationRecord
    has_many :translations, dependent: :destroy
    # Note: Learn about the design decisions behind this: https://github.com/virolea/rosetta/issues/3
    has_one :translation_in_current_locale, -> { where(locale_id: Rosetta.locale.id) }, class_name: "Translation", dependent: :destroy
  end
end
