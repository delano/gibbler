# frozen_string_literal: true

require_relative "lib/gibbler"

Gem::Specification.new do |spec|
  spec.name = "gibbler"
  spec.version = '0.10.0'  # Gibbler::VERSION.to_s
  spec.authors = ["delano"]
  spec.email = ["delano@cpan.org"]

  spec.summary = "Gibbler: Git-like hashes for Ruby objects"
  spec.description = spec.summary
  spec.homepage = "https://github.com/delano/gibbler"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/delano/gibbler"
  spec.metadata["changelog_uri"] = "https://github.com/delano/gibbler/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "attic", "~> 0.4.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
