module Rosetta
  class Locales::TranslationsController < ApplicationController
    include LocaleScoped

    def index
      @pagy, @text_entries = pagy(scope)

      render "rosetta/locales/translations/index"
    end

    private

    def scope
      TextEntry.with_translated_version(@locale).where(locale: Locale.default_locale)
    end
  end
end
