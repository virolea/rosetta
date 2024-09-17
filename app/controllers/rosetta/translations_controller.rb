module Rosetta
  class TranslationsController < ApplicationController
    include LocaleScoped

    before_action :set_translation_key
    before_action :set_translation

    def edit
    end

    def update
      if translation_params[:value].blank?
        @translation_key.translation_in_current_locale = nil
      else
        @translation.update(translation_params)
      end

      render partial: "rosetta/locales/translations/translation_key", locals: { translation_key: @translation_key }
    end

    private

    def set_translation_key
      @translation_key = TranslationKey.find(params[:translation_key_id])
    end

    def set_translation
      @translation = @translation_key.translation_in_current_locale || @translation_key.build_translation_in_current_locale
    end

    def translation_params
      params.require(:translation).permit(:value)
    end
  end
end
