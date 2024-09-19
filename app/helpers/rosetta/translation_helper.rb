module Rosetta
  module TranslationHelper
    def _(key, locale: Rosetta.locale)
      return key if Rosetta.locale.default_locale?

      Rosetta.translate(key, locale: locale) || key
    end
  end
end
