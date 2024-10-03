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
  end

  test "#with_locale" do
    locale = rosetta_locales(:french)

    Rosetta.with_locale(locale) do
      assert_equal Rosetta.locale, locale
    end

    assert_equal Rosetta.locale, Rosetta::Locale.default_locale
  end

  test "#translate translates the key in the selected locale" do
    Rosetta.with_locale(rosetta_locales(:french)) { assert_equal "bonjour", Rosetta.translate("hello") }
    assert_equal "bonjour", Rosetta.translate("hello", locale: rosetta_locales(:french))
    assert_equal "hola", Rosetta.translate("hello", locale: rosetta_locales(:spanish))
  end
end
