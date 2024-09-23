module Rosetta
  class Locale < ApplicationRecord
    CODE_FORMAT = /\A[a-zA-Z]+(-[a-zA-Z]+)?\z/

    validates :name, :code, presence: true
    validates :code, uniqueness: true
    validates :code, format: { with: CODE_FORMAT, message: "must only contain letters separated by an optional dash" }

    has_many :translations, dependent: :destroy

    class << self
      def available_locales
        all
      end

      def build_as_default(params)
        new(params.merge(default: true))
      end

      def default_locale
        @default_locale ||= find_by(default: true)
      end
    end
  end
end
