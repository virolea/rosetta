module Rosetta
  class Locale < ApplicationRecord
    CODE_FORMAT = /\A[a-z]+(-[A-Z]+)?\z/

    validates :name, :code, presence: true
    validates :code, uniqueness: true
    validates :code, format: { with: CODE_FORMAT, message: "must only contain letters separated by an optional dash" }

    class << self
      def available_locales
        all # .published
      end

      # The default locale is the locale in which the application is written.
      # Default is english.
      # TODO: Make this configurable.
      def default
        new(name: "English", code: "en").as_default
      end
    end

    def default_locale?
      @default_locale ||= false
    end

    def as_default
      @default_locale = true
      self
    end
  end
end
