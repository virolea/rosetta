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

      def default_locale
        @default_locale ||= new(Rosetta.config.default_locale.to_h).as_default
      end
    end

    def default_locale?
      @default
    end

    def as_default
      @default = true
      readonly!
      self
    end
  end
end
