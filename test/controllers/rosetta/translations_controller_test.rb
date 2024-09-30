require "test_helper"

module Rosetta
  class TranslationsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @locale = rosetta_locales(:french)
      @key = rosetta_translation_keys(:goodbye)
    end

    test "edit" do
      get edit_translation_key_translation_path(@key, locale_id: @locale.id)
      assert_response :success
    end

    test "add a new translation" do
      assert_difference("Translation.count", 1) do
        patch translation_key_translation_path(@key), params: { locale_id: @locale.id, translation_key: { value_fr: "Au revoir" } }
      end

      assert_equal "Au revoir", Translation.last.value
      assert_response :success
      assert_includes response.body, @key.value
    end

    test "update an existing translation" do
      Translation.create!(locale: @locale, translation_key: @key, value: "Salut")

      assert_no_difference("Translation.count") do
        patch translation_key_translation_path(@key), params: { locale_id: @locale.id, translation_key: { value_fr: "Bonjour" } }
      end

      assert_equal "Bonjour", Translation.last.value
      assert_response :success
      assert_includes response.body, @key.value
    end

    test "setting a blank value removes the translation" do
      Translation.create!(locale: @locale, translation_key: @key, value: "Salut")

      assert_difference("Translation.count", -1) do
        patch translation_key_translation_path(@key), params: { locale_id: @locale.id, translation_key: { value_fr: "" } }
      end

      assert_response :success
      assert_includes response.body, @key.value
    end
  end
end
