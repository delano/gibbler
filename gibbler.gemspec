Gem::Specification.new do |s|
    s.name        = "gibbler"
    s.version     = "0.10.0"
    s.summary     = "Git-like hashes for Ruby objects"
    s.description = "About Gibbler: Git-like hashes for Ruby objects"
    s.authors     = ["Delano Mandelbaum"]
    s.email       = "gems@solutious.com"
    s.homepage    = "https://github.com/delano/gibbler"
    s.license     = "MIT"

    s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
    s.bindir        = "exe"
    s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
    s.require_paths = ["lib"]

    s.required_ruby_version = Gem::Requirement.new(">= 2.6.8")

    s.add_dependency "rake", "~> 13.0"

    s.add_development_dependency "rubocop", "~> 1.0"
    s.add_development_dependency "tryouts", "~> 2.2"
  end
