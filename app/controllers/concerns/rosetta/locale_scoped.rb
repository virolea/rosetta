module Rosetta
  module LocaleScoped
    extend ActiveSupport::Concern

    included do
      before_action :set_locale
    end

    private

    def set_locale(&action)
      @locale = Locale.find(params[:locale_id])
    end
  end
end
