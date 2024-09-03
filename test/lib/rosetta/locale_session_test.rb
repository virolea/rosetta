require "test_helper"

class Rosetta::LocaleSessionTest < ActiveSupport::TestCase
  test "locale is the default locale by default" do
    assert_equal Rosetta::Locale.default_locale, Rosetta::LocaleSession.new.locale
  end

  test "assigning a locale as a string" do
    locale = Rosetta::Locale.create(name: "French", code: "fr")
    session = Rosetta::LocaleSession.new
    session.locale = locale.code
    assert_equal locale, session.locale
  end

  test "assigning the locale as a locale object" do
    locale = Rosetta::Locale.create(name: "French", code: "fr")
    session = Rosetta::LocaleSession.new
    session.locale = locale
    assert_equal locale, session.locale
  end

  test "assigning a non-existing locale fallbacks to the default locale" do
    session = Rosetta::LocaleSession.new
    session.locale = "non-existing"
    assert_equal Rosetta::Locale.default_locale, session.locale
  end
end
