require "rosetta/version"
require "rosetta/engine"

require "rosetta/locale_session"
require "rosetta/store"
require "rosetta/configuration"

module Rosetta
  module Base
    def locale
      locale_session.locale
    end

    def locale=(code)
      locale_session.locale = code
    end

    def with_locale(locale, &block)
      locale_was = Rosetta.locale
      self.locale = locale

      begin
        yield
      ensure
        self.locale = locale_was
      end
    end

    def locale_session
      Thread.current[:rosetta_locale_session] ||= LocaleSession.new
    end

    def store
      Store.for_locale(Rosetta.locale)
    end

    def config
      @configuration ||= Configuration.new
    end

    def configure
      config.tap { |config| yield(config) }
    end
  end

  extend Base
end
