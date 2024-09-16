module Rosetta
  class Locales::TranslationsController < ApplicationController
    include LocaleScoped

    def index
      @pagy, @translations = pagy(scope)

      render "rosetta/locales/translations/index"
    end

    private

    def scope
      TranslationKey.all_in_locale(@locale)
    end
  end
end
