module Rosetta
  module LocaleScoped
    extend ActiveSupport::Concern

    included do
      around_action :set_locale
    end

    private

    def set_locale(&action)
      @locale = Locale.find(params[:locale_id])
      Rosetta.with_locale(@locale, &action)
    end
  end
end
