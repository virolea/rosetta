require_relative "lib/rosetta/version"

Gem::Specification.new do |spec|
  spec.name        = "rosetta-rails"
  spec.version     = Rosetta::VERSION
  spec.authors     = [ "Vincent Rolea" ]
  spec.email       = [ "3525369+virolea@users.noreply.github.com" ]
  spec.homepage    = "https://github.com/virolea/rosetta"
  spec.summary     = "Unobstrusive Internationalization solution for Rails applications."
  spec.description = spec.summary
  spec.license     = "MIT"

  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 6.1.0"
  spec.add_dependency "turbo-rails", "~> 2.0"
  spec.add_dependency "concurrent-ruby", "~>1.3"
  spec.add_dependency "pagy", ">= 7.0"

  spec.add_development_dependency "appraisal"
end
