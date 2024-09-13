require "test_helper"

module Rosetta
  class Locales::TranslationsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "index" do
      locale = rosetta_locales(:french)
      key = rosetta_translation_keys(:hello)
      get locale_translations_path(locale)
      assert_response :success
      assert_includes response.body, "hello"
    end
  end
end
