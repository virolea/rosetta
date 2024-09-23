module Rosetta
  class DefaultLocalesController < ApplicationController
    before_action :ensure_configuration_needed

    def new
        @locale = Locale.new
    end

    def create
      @locale = Locale.build_as_default(locale_params)

      if @locale.save
        redirect_to locales_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def ensure_configuration_needed
      redirect_to root_path if Locale.any?
    end

    def locale_params
      params.require(:locale).permit(:name, :code)
    end
  end
end
