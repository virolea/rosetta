module Rosetta
  class TranslationsController < ApplicationController
    before_action :set_locale
    before_action :set_translation_key
    before_action :set_translation

    def edit
    end

    def update
      if @translation.update(translation_params)
        redirect_to locale_translation_keys_path(@locale)
      end
    end

    private

    def set_locale
      @locale = Locale.find(params[:locale_id])
    end

    def set_translation_key
      @translation_key = TranslationKey.find(params[:translation_key_id])
    end

    def set_translation
      @translation = @translation_key.translations.find_or_initialize_by(locale: @locale)
    end

    def translation_params
      params.require(:translation).permit(:value)
    end
  end
end
