require "turbo-rails"

module Rosetta
  class Engine < ::Rails::Engine
    isolate_namespace Rosetta

    initializer "rosetta.assets.precompile" do |app|
      app.config.assets.precompile += %w[rosetta_manifest.js]
    end
  end
end
