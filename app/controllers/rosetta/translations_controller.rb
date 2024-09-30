module Rosetta
  class TranslationsController < ApplicationController
    include LocaleScoped

    before_action :set_translation_key

    def edit
    end

    def update
      @translation_key.update(translation_key_params)

      render partial: "rosetta/locales/translations/translation_key", locals: { translation_key: @translation_key }
    end

    private

    def set_translation_key
      @translation_key = TranslationKey.find(params[:translation_key_id])
    end

    def translation_key_params
      params.require(:translation_key).permit(:"value_#{@locale.code}")
    end
  end
end
