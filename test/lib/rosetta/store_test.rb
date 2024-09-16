require "test_helper"
require "minitest/mock"

class Rosetta::StoreTest < ActiveSupport::TestCase
  setup do
    @locale = rosetta_locales(:french)
    @store = Rosetta::Store.for_locale(@locale)
  end

  test "self#store_for_locale returns the store instance for the given locale" do
    refetched_store = Rosetta::Store.for_locale(@locale)
    assert_instance_of Rosetta::Store, @store
    assert_equal @store, refetched_store
    assert_equal @store.locale, @locale
  end

  test "#translations returns the translations for the given locale as well as existing untranslated keys" do
    assert_equal({ "hello"=>"bonjour", "goodbye"=>nil }, @store.translations)
  end

  test "looking up an existing translation" do
    assert_equal "bonjour", @store.lookup("hello")
  end

  test "looking up an untranslated key" do
    assert_nil @store.lookup("goodbye")
  end

  test "looking up a key that doesn't exist creates a new key and adds the key to the translations" do
    assert_difference("Rosetta::TranslationKey.count", 1) do
      @store.lookup("missing key")
      sleep 1
    end

    assert @store.translations.has_key?("missing key")
  ensure
    @store.reload!
  end
end
