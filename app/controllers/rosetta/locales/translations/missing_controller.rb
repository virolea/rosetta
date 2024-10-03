module Rosetta
  class Locales::Translations::MissingController < Locales::TranslationsController
    private

    def scope
      Locale.default_locale.text_entries.missing_translation(@locale)
    end
  end
end
