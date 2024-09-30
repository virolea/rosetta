module Rosetta
  class Locales::Translations::MissingController < Locales::TranslationsController
    private

    def scope
      TranslationKey.with_missing_translation(@locale)
    end
  end
end
