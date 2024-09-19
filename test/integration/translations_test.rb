require "test_helper"

class TranslationsTest < ActionDispatch::IntegrationTest
  teardown do
    Rosetta::Store.for_locale(rosetta_locales(:french)).reload!
  end

  test "translations show up when available and fallback if not" do
    get root_path(locale: "fr")

    assert_select "h1", "Homepage"
    assert_select "h3", "bonjour"
  end

  test "visiting the page loads up the missing keys" do
    assert_difference("Rosetta::TranslationKey.count", 18) do
      get root_path(locale: "fr")
    end
  end

  test "deploying a new translation" do
    locale = rosetta_locales(:french)

    # Load up the keys
    get root_path(locale: locale.code)
    key = Rosetta::TranslationKey.find_by(value: "Available locales")

    # Create the translation
    patch rosetta.translation_key_translation_path(key), params: { locale_id: locale.id, translation: { value: "Langues disponibles" } }

    # Deploy the changes
    post rosetta.locale_deploys_path(locale)
    follow_redirect!

    get "/?locale=fr"
    assert_select "h3", "Langues disponibles"
  end
end
