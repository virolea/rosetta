require "test_helper"

module Rosetta
  class Locales::DeploysControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "deploying a new version of translations" do
      locale = rosetta_locales(:french)

      assert_changes("locale.reload.updated_at") do
        post locale_deploys_path(locale)
      end

      assert_redirected_to locale_translations_path(locale)
    end
  end
end
