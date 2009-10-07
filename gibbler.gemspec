@spec = Gem::Specification.new do |s|
	s.name = "gibbler"
  s.rubyforge_project = "gibbler"
	s.version = "0.7.0"
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
  lib/gibbler/digest.rb
  lib/gibbler/history.rb
  lib/gibbler/mixins.rb
  lib/gibbler/mixins/string.rb
  lib/gibbler/object.rb
  tryouts/01_mixins_tryouts.rb
  tryouts/02_compat_tryouts.rb
  tryouts/05_gibbler_digest_tryouts.rb
  tryouts/10_basic_tryouts.rb
  tryouts/11_basic_sha256_tryouts.rb
  tryouts/14_extended_tryouts.rb
  tryouts/15_file_tryouts.rb
  tryouts/16_uri_tryouts.rb
  tryouts/20_time_tryouts.rb
  tryouts/50_history_tryouts.rb
  tryouts/51_hash_history_tryouts.rb
  tryouts/52_array_history_tryouts.rb
  tryouts/53_string_history_tryouts.rb
  tryouts/57_arbitrary_history_tryouts.rb
  tryouts/59_history_exceptions_tryouts.rb
  tryouts/80_performance_tryouts.rb
  tryouts/90_alias_tryouts.rb
  tryouts/object_hash_demo.rb
  )
  
  s.has_rdoc = true
  s.rubygems_version = '1.3.0'
  
end