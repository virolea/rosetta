require "test_helper"
require "minitest/mock"

class Rosetta::LocaleTest < ActiveSupport::TestCase
  test "valid locale" do
    assert Rosetta::Locale.new(name: "Italian", code: "it").valid?
  end

  test "default unpublished" do
    assert_not Rosetta::Locale.new(name: "Italian", code: "it").published
  end

  test "invalid without a name" do
    locale = Rosetta::Locale.new(name: nil, code: "it")
    locale.valid?
    assert_not locale.errors[:name].empty?
  end

  test "invalid without a code" do
    locale = Rosetta::Locale.new(name: "Italian", code: nil)
    locale.valid?
    assert_not locale.errors[:code].empty?
  end

  test "invalid with a duplicate code" do
    Rosetta::Locale.create(name: "Italian", code: "it")
    locale = Rosetta::Locale.new(name: "Italian", code: "it")
    locale.valid?
    assert_not locale.errors[:code].empty?
  end

  test "code format" do
    assert     Rosetta::Locale.new(name: "Italian", code: "it").valid?
    assert     Rosetta::Locale.new(name: "Italian", code: "IT").valid?
    assert     Rosetta::Locale.new(name: "Italian", code: "it-IT").valid?
    assert     Rosetta::Locale.new(name: "Italian", code: "IT-it").valid?
    assert_not Rosetta::Locale.new(name: "Italian", code: "it-IT-IT").valid?
    assert_not Rosetta::Locale.new(name: "Italian", code: "qw12").valid?
  end

  test "available locales" do
    assert_equal 3, Rosetta::Locale.available_locales.length
    assert_equal [ :en, :fr, :es ], Rosetta::Locale.available_locales.pluck(:code).map(&:to_sym)
  end

  test "default locale" do
    default_locale = Rosetta::Locale.default_locale
    assert_equal "English", default_locale.name
    assert_equal "en", default_locale.code
    assert default_locale.default?
  end

  test "creating a new locale notifies translated models" do
    translated_model = Minitest::Mock.new
    translated_model.expect(:translated_in, nil, [ Rosetta::Locale ])

    Rosetta::Locale.register_class_for_translation(translated_model)
    Rosetta::Locale.create(name: "Italian", code: "it")

    assert translated_model.verify
  end
end
