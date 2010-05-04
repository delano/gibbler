@spec = Gem::Specification.new do |s|
	s.name = "gibbler"
  s.rubyforge_project = "gibbler"
	s.version = "0.8.3"
	s.summary = "Gibbler: Git-like hashes for Ruby objects"
	s.description = s.summary
	s.author = "Delano Mandelbaum"
	s.email = "delano@solutious.com"
	s.homepage = "http://github.com/delano/gibbler"
  
  # = EXECUTABLES =
  # The list of executables in your project (if any). Don't include the path, 
  # just the base filename.
  s.executables = %w[]
  
  # Directories to extract rdocs from
  s.require_paths = %w[lib]  
  
  # Specific files to include rdocs from
  s.extra_rdoc_files = ["README.rdoc", "LICENSE.txt"]
  s.has_rdoc = true
  
  # Update --main to reflect the default page to display
  s.rdoc_options = ["--line-numbers", "--title", s.summary, "--main", "README.rdoc"]
  
  # = DEPENDENCIES =
  s.add_dependency 'attic',   '>= 0.4.0'
  
  # = MANIFEST =
  s.files = %w(
  CHANGES.txt
  LICENSE.txt
  README.rdoc
  Rakefile
  gibbler.gemspec
  lib/gibbler.rb
  lib/gibbler/aliases.rb
  lib/gibbler/history.rb
  lib/gibbler/mixins.rb
  )
  
  s.has_rdoc = true
  s.rubygems_version = '1.3.0'
  
end