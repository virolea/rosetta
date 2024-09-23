require "test_helper"

module Rosetta
  class DefaultLocalesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      Locale.destroy_all
      Locale.default_locale = nil
    end

    test "new" do
      get new_default_locale_path
      assert_response :success
      assert_includes response.body, "Setup default locale"
    end

    test "create default locale" do
      assert_difference("Locale.count", 1) do
        post default_locale_path, params: { locale: { name: "English", code: "en" } }
      end

      assert_redirected_to locales_path
    end

    test "redirects if the default locale already exists" do
      locale = Locale.create(name: "English", code: "en")
      Locale.default_locale = locale

      assert_no_difference("Locale.count") do
        post default_locale_path, params: { locale: { name: "English", code: "en" } }
      end

      assert_redirected_to root_path
    end
  end
end
