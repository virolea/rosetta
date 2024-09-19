class ApplicationController < ActionController::Base
  around_action :set_locale

  private

  def set_locale
    if params[:locale]
      Rosetta.with_locale(params[:locale]) { yield }
    end
  end
end
