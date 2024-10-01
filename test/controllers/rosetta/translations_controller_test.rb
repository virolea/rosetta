require "test_helper"

module Rosetta
  class TranslationsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @locale = rosetta_locales(:french)
      @text_entry = rosetta_text_entries(:goodbye)
    end

    test "edit" do
      get edit_text_entry_translation_path(@text_entry, locale_id: @locale.id)
      assert_response :success
    end

    test "add a new translation" do
      assert_difference("Translation.count", 1) do
        patch text_entry_translation_path(@text_entry), params: { locale_id: @locale.id, text_entry: { content_fr: "Au revoir" } }
      end

      assert_equal "Au revoir", @text_entry.content_fr
      assert_response :success
      assert_includes response.body, @text_entry.content
    end

    test "setting a blank value removes the translation" do
      @text_entry.update(content_fr: "Au revoir")

      assert_difference("Translation.count", -1) do
        patch text_entry_translation_path(@text_entry), params: { locale_id: @locale.id, text_entry: { content_fr: "" } }
      end

      assert_response :success
    end
  end
end
