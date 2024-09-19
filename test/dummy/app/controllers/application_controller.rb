class ApplicationController < ActionController::Base
  around_action :set_locale

  private

  def set_locale(&action)
    Rosetta.with_locale(params[:locale], &action)
  end
end
