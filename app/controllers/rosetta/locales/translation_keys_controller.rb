module Rosetta
  class Locales::TranslationKeysController < ApplicationController
    before_action :set_locale

    def index
      @pagy, @translation_keys = pagy(TranslationKey
        .includes(:translations)
        .joins("LEFT JOIN rosetta_translations ON rosetta_translations.translation_key_id = rosetta_translation_keys.id AND rosetta_translations.locale_id = #{@locale.id}")
        .order(created_at: :desc)
      )
    end

    private

    def set_locale
      @locale = Locale.find(params[:locale_id])
    end
  end
end
