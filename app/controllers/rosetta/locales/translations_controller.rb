module Rosetta
  class Locales::TranslationsController < ApplicationController
    before_action :set_locale

    def index
      @pagy, @translations = pagy(scope)

      render "rosetta/locales/translations/index"
    end

    private

    def scope
      TranslationKey.all_in_locale(@locale)
    end

    def set_locale
      @locale = Locale.find_by!(code: params[:locale_id])
    end
  end
end
