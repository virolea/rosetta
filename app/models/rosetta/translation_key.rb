module Rosetta
  class TranslationKey < ApplicationRecord
    has_many :translations, dependent: :destroy
  end
end
