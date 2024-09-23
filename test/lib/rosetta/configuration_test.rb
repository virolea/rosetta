require "test_helper"

class Rosetta::ConfigurationTest < ActiveSupport::TestCase
  test "new config sets the default locale as english" do
    config = Rosetta::Configuration.new
    assert_equal config.default_locale, Rosetta::Configuration::DefaultLocale.new("English", "en")
  end

  test "setting up the default locale" do
    config = Rosetta::Configuration.new
    config.set_default_locale(name: "French", code: "fr")
    assert_equal config.default_locale, Rosetta::Configuration::DefaultLocale.new("French", "fr")
  end
end
