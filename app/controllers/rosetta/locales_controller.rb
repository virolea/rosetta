module Rosetta
  class LocalesController < ApplicationController
    def index
      @locales = [ Locale.default_locale ] + Locale.all
    end

    def new
      @locale = Locale.new
    end

    def create
      @locale = Locale.new(locale_params)

      if @locale.save
        redirect_to locales_path
      else
       render turbo_stream: turbo_stream.update(
         :dialog_content,
         partial: "form",
         locals: { locale: @locale }
       )
      end
    end

    private

    def locale_params
      params.require(:locale).permit(:name, :code)
    end
  end
end
