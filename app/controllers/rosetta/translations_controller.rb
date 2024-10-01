module Rosetta
  class TranslationsController < ApplicationController
    include LocaleScoped

    before_action :set_text_entry

    def edit
    end

    def update
      @text_entry.update(text_entry_params)

      render partial: "rosetta/text_entries/text_entry_with_translation", locals: { text_entry: @text_entry }
    end

    private

    def set_text_entry
      @text_entry = TextEntry.find(params[:text_entry_id])
    end

    def text_entry_params
      params.require(:text_entry).permit(:"content_#{@locale.code}")
    end
  end
end
