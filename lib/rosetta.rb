require "rosetta/version"
require "rosetta/engine"

require "rosetta/locale_session"
require "rosetta/store"

module Rosetta
  module Base
    def locale
      locale_session.locale
    end

    def locale=(code)
      locale_session.locale = code
    end

    def locale_session
      Thread.current[:rosetta_locale_session] ||= LocaleSession.new
    end

    def store
      Store.for_locale(Rosetta.locale)
    end
  end

  extend Base
end
