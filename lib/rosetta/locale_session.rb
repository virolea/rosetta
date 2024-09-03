module Rosetta
  class LocaleSession
    def locale
      @locale ||= Locale.default_locale
    end

    def locale=(value)
      case value
      when Locale
        @locale = value
      when String, Symbol
        @locale = Locale.find_by(code: value) || Locale.default
      end
    end
  end
end
