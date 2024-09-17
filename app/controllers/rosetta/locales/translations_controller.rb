module Rosetta
  class Locales::TranslationsController < ApplicationController
    include LocaleScoped

    def index
      @pagy, @translation_keys = pagy(scope)

      render "rosetta/locales/translations/index"
    end

    private

    def scope
      TranslationKey.includes(:translation_in_current_locale)
    end
  end
end
