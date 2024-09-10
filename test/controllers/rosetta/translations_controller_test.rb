require "test_helper"

module Rosetta
  class TranslationsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @locale = Locale.create!(code: "fr", name: "French")
      @key = TranslationKey.create!(value: "Hello")
    end

    test "edit" do
      get edit_translation_key_translation_path(@key, locale_id: @locale.id)
      assert_response :success
    end

    test "add a new translation" do
      assert_difference("Translation.count", 1) do
        patch translation_key_translation_path(@key), params: { locale_id: @locale.id, translation: { value: "Bonjour" } }
      end

      assert_equal "Bonjour", Translation.last.value
      assert_response :redirect
      assert_redirected_to locale_translation_keys_path(@locale)
    end

    test "update an existing translation" do
      Translation.create!(locale: @locale, translation_key: @key, value: "Salut")

      assert_no_difference("Translation.count") do
        patch translation_key_translation_path(@key), params: { locale_id: @locale.id, translation: { value: "Bonjour" } }
      end

      assert_equal "Bonjour", Translation.last.value
      assert_response :redirect
      assert_redirected_to locale_translation_keys_path(@locale)
    end
  end
end
