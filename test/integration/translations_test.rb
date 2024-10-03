require "test_helper"

class TranslationsTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  teardown do
    Rosetta::Store.for_locale(rosetta_locales(:french)).reload!
  end

  test "translations show up when available and fallback if not" do
    get root_path(locale: "fr")

    assert_select "h1", "Homepage"
    assert_select "h3", "bonjour"
  end

  test "visiting the page syncs up the missing keys" do
    assert_enqueued_jobs 19 do
      get root_path(locale: "fr")
    end
  end

  test "deploying a new translation" do
    locale = rosetta_locales(:french)
    key = Rosetta::TextEntry.create(content: "Available locales", locale: rosetta_locales(:english))

    # Create the translation
    patch rosetta.text_entry_translation_path(key), params: { locale_id: locale.id, text_entry: { content_fr: "Langues disponibles" } }

    # Deploy the changes
    post rosetta.locale_deploys_path(locale)
    follow_redirect!

    get "/?locale=fr"
    assert_select "h3", "Langues disponibles"
  end
end
