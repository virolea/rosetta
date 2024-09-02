module Rosetta
  class Locale < ApplicationRecord
    CODE_FORMAT = /\A[a-z]+(-[A-Z]+)?\z/

    validates :name, :code, presence: true
    validates :code, uniqueness: true
    validates :code, format: { with: CODE_FORMAT, message: "must only contain letters separated by an optional dash" }

    class << self
      def available_locales
        pluck(:code).map(&:to_sym)
      end
    end
  end
end
