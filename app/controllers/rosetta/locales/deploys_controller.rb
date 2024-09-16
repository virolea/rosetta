module Rosetta
  class Locales::DeploysController < ApplicationController
    include LocaleScoped

    def create
      @locale.touch
      flash[:notice] = "#{@locale.name} changes have been deployed."

      redirect_to locale_translations_path(@locale)
    end
  end
end
