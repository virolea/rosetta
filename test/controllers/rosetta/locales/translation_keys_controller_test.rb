require "test_helper"

module Rosetta
  class Locales::TranslationKeysControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "index" do
      locale = Locale.create(code: "fr", name: "French")
      key = TranslationKey.create(value: "hello")
      get locale_translation_keys_path(locale)
      assert_response :success
      assert_includes response.body, "hello"
    end
  end
end
