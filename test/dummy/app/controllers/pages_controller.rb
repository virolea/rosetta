class PagesController < ApplicationController
  before_action :set_locale

  private

  def set_locale
    if params[:locale]
      Rosetta.locale = params[:locale]
    end
  end
end
