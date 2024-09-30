module Rosetta
  class TranslationsController < ApplicationController
    include LocaleScoped

    before_action :set_translation_key
    before_action :set_translation

    def edit
    end

    def update
      if translation_params[:value].blank?
        @translation_key.public_send(:"#{@locale.code}_translation=", nil)
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
      @translation = @translation_key.public_send(:"#{@locale.code}_translation") ||
        @translation_key.public_send(:"build_#{@locale.code}_translation")
    end

    def translation_params
      params.require(:translation).permit(:value)
    end
  end
end
