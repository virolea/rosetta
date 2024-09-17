module Rosetta
  class Locales::Translations::MissingController < Locales::TranslationsController
    private

    def scope
      super.where.missing(:translation_in_current_locale)
    end
  end
end
