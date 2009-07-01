@spec = Gem::Specification.new do |s|
	s.name = "gibbler"
  s.rubyforge_project = "gibbler"
	s.version = "0.4"
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
  
  # = MANIFEST =
  s.files = %w(
  CCHANGES.txt
  LICENSE.txt
  README.rdoc
  Rakefile
  gibbler.gemspec
  lib/gibble.rb
  lib/gibbler.rb
  lib/gibbler/history.rb
  lib/gibbler/mixins.rb
  lib/gibbler/mixins/string.rb
  tryouts/10_basic_tryouts.rb
  tryouts/11_basic_sha256_tryouts.rb
  tryouts/20_gibble_tryouts.rb
  tryouts/50_history_tryouts.rb
  tryouts/80_performance_tryouts.rb
  tryouts/object_hash_demo.rb
  )
  
  s.has_rdoc = true
  s.rubygems_version = '1.3.0'
  
end