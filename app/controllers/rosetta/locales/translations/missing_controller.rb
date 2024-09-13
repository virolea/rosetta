module Rosetta
  class Locales::Translations::MissingController < Locales::TranslationsController
    private

    def scope
      TranslationKey.with_missing_translation_in_locale(@locale)
    end
  end
end
