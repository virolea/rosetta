module Rosetta
  class Locales::TranslationsController < ApplicationController
    include LocaleScoped

    def index
      @pagy, @translation_keys = pagy(scope)

      render "rosetta/locales/translations/index"
    end

    private

    def scope
      TranslationKey.with_translation(@locale)
    end
  end
end
