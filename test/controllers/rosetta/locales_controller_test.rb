require "test_helper"

module Rosetta
  class LocalesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "index" do
      get locales_path
      assert_response :success
      assert_includes response.body, "Locales"
    end

    test "redirects to the new default locale if no locale" do
      Locale.destroy_all
      get locales_path
      assert_redirected_to new_default_locale_path
    end

    test "new" do
      get new_locale_path
      assert_response :success
    end

    test "create with valid input" do
      assert_difference("Locale.count", 1) do
        post locales_path, params: { locale: { code: "de", name: "German" } }
      end

      assert_redirected_to locales_path
    end

    test "create with invalid input" do
      assert_no_difference("Locale.count") do
        post locales_path, params: { locale: { code: "fr" } }
      end

      assert_response :success
    end
  end
end
