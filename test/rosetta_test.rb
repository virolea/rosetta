require "test_helper"

class RosettaTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert Rosetta::VERSION
  end

  test "self.locale returns the default locale by default" do
    assert_equal Rosetta.locale, Rosetta::Locale.default_locale
  end

  test "self.locale returns the configured locale" do
    locale = Rosetta::Locale.new(name: "French", code: "fr")
    Rosetta.locale = locale
    assert_equal Rosetta.locale, locale
  ensure
    Rosetta.locale = Rosetta::Locale.default_locale
  end

  test "configuring the default locale" do
    Rosetta.configure { |config| config.set_default_locale(name: "French", code: "fr") }
    assert_equal "French", Rosetta.config.default_locale.name
  end
end
