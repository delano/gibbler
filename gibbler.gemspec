# frozen_string_literal: true

require_relative "lib/gibbler"

Gem::Specification.new do |spec|
  spec.name = "gibbler"
  spec.version = Gibbler::VERSION
  spec.authors = ["delano"]
  spec.email = ["delano@cpan.org"]

  spec.summary = "Gibbler: Git-like hashes for Ruby objects"
  spec.description = spec.summary
  spec.homepage = "https://github.com/delano/gibbler"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/delano/gibbler"
  spec.metadata["changelog_uri"] = "https://github.com/delano/gibbler/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").grep_v(%r{\A(bin/|test/|spec/|features/|.git|.circleci|appveyor)})
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.metadata["rubygems_mfa_required"] = "true"
end
