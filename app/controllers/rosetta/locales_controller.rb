module Rosetta
  class LocalesController < ApplicationController
    before_action :ensure_default_locale_exists, only: :index

    def index
      @locales = Locale.all
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

    def ensure_default_locale_exists
      redirect_to new_default_locale_path unless Locale.default_locale
    end

    def locale_params
      params.require(:locale).permit(:name, :code)
    end
  end
end
