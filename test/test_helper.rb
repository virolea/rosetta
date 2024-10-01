# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require_relative "../test/dummy/config/environment"
ActiveRecord::Migrator.migrations_paths = [ File.expand_path("../test/dummy/db/migrate", __dir__) ]
ActiveRecord::Migrator.migrations_paths << File.expand_path("../db/migrate", __dir__)
require "rails/test_help"

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_paths=)
  ActiveSupport::TestCase.fixture_paths = [ File.expand_path("fixtures", __dir__) ]
  ActionDispatch::IntegrationTest.fixture_paths = ActiveSupport::TestCase.fixture_paths
  ActiveSupport::TestCase.file_fixture_path = File.expand_path("fixtures", __dir__) + "/files"
  ActiveSupport::TestCase.fixtures :all
# Note: Remove after Rails 7.0 support drop
elsif ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("fixtures", __dir__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = ActiveSupport::TestCase.fixture_path + "/files"
  ActiveSupport::TestCase.fixtures :all
end
# End Note

class ActiveSupport::TestCase
  setup do
    reset_locale_setup
    ensure_translation_associations_loaded
    Rosetta::Locale.default_locale = nil
    Rosetta::Store.locale_stores.each { |code, store| store.reload! }
    Rosetta.locale = :en
  end

  private

  # Provide a clean slate for each test:
  # - Unset the default locale
  # - Reload all locale stores
  # - Reset the registered classes for translations
  # - Set the locale to the default locale
  def reset_locale_setup
    Rosetta::Locale.default_locale = nil
    Rosetta::Store.locale_stores.each { |code, store| store.reload! }
    Rosetta::Locale.registered_classes_for_translations = []
    Rosetta.locale = :en
  end

  # Fixtures are loaded after the code, hence association for the locale fixtures
  # are not loaded when the tests start.
  def ensure_translation_associations_loaded
    return if Rosetta::TextEntry.respond_to?(:fr_translation)

    Rosetta::TextEntry.translate_in_all_locales
  end
end
