Gem::Specification.new do |s|
    s.name        = "gibbler"
    s.version     = "0.10.0-RC1"
    s.summary     = "Git-like hashes for Ruby objects"
    s.description = "A out Gibbler: Git-like hashes for Ruby objects"
    s.authors     = ["Delano Mandelbaum"]
    s.email       = "gems@solutious.com"
    s.homepage    = "http://github.com/delano/gibbler"
    s.license     = "MIT"

    s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
    s.bindir        = "exe"
    s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
    s.require_paths = ["lib"]

    s.required_ruby_version = Gem::Requirement.new(">= 3.1.4")

    s.add_dependency "rake"

    s.add_development_dependency "rubocop"
    s.add_development_dependency "tryouts", "2.2.0.pre.RC1"
  end
