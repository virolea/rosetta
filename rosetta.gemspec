require_relative "lib/rosetta/version"

Gem::Specification.new do |spec|
  spec.name        = "rosetta"
  spec.version     = Rosetta::VERSION
  spec.authors     = [ "Vincent Rolea" ]
  spec.email       = [ "3525369+virolea@users.noreply.github.com" ]
  spec.homepage    = "https://github.com/virolea/rosetta"
  spec.summary     = "Next-level internationalization for Rails applications."
  spec.description = spec.summary
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.2.0"
  spec.add_dependency "turbo-rails", "~> 2.0"
end
