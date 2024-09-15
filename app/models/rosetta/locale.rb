module Rosetta
  class Locale < ApplicationRecord
    CODE_FORMAT = /\A[a-zA-Z]+(-[a-zA-Z]+)?\z/

    validates :name, :code, presence: true
    validates :code, uniqueness: true
    validates :code, format: { with: CODE_FORMAT, message: "must only contain letters separated by an optional dash" }

    has_many :translations, dependent: :destroy

    class << self
      def available_locales
        [ Locale.default_locale ] + all
      end

      # The default locale is the locale in which the application is written.
      # Default is english.
      # TODO: Make this configurable.
      def default_locale
        @default_locale ||= new(name: "English", code: "en").as_default
      end
    end

    def to_param
      code
    end

    def default_locale?
      @default ||= false
    end

    def as_default
      @default = true
      readonly!
      self
    end
  end
end
