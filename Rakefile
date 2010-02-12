require 'rubygems'
require 'rake/clean'
require 'rake/gempackagetask'
require 'fileutils'
include FileUtils

begin
  require 'hanna/rdoctask'
rescue LoadError
  require 'rake/rdoctask'
end


task :default => :package
 
# CONFIG =============================================================

# Change the following according to your needs
README = "README.rdoc"
CHANGES = "CHANGES.txt"
LICENSE = "LICENSE.txt"

# Files and directories to be deleted when you run "rake clean"
CLEAN.include [ 'pkg', '*.gem', '.config', 'doc']

name = 'gibbler'
load "#{name}.gemspec"
version = @spec.version

# That's it! The following defaults should allow you to get started
# on other things. 


# TESTS/SPECS =========================================================



# INSTALL =============================================================

Rake::GemPackageTask.new(@spec) do |p|
  p.need_tar = true if RUBY_PLATFORM !~ /mswin/
end

task :release => [ :rdoc, :package ]
task :install => [ :rdoc, :package ] do
	sh %{sudo gem install pkg/#{name}-#{version}.gem}
end
task :uninstall => [ :clean ] do
	sh %{sudo gem uninstall #{name}}
end


# RUBYFORGE RELEASE / PUBLISH TASKS ==================================

if @spec.rubyforge_project
  desc 'Publish website to rubyforge'
  task 'publish:rdoc' => 'doc/index.html' do
    sh "scp -rp doc/* rubyforge.org:/var/www/gforge-projects/#{name}/"
  end

  desc 'Public release to rubyforge'
  task 'publish:gem' => [:package] do |t|
    sh <<-end
      rubyforge add_release -o Any -a #{CHANGES} -f -n #{README} #{name} #{name} #{@spec.version} pkg/#{name}-#{@spec.version}.gem &&
      rubyforge add_file -o Any -a #{CHANGES} -f -n #{README} #{name} #{name} #{@spec.version} pkg/#{name}-#{@spec.version}.tgz 
    end
  end
end



# RUBY DOCS TASK ==================================

Rake::RDocTask.new do |t|
	t.rdoc_dir = 'doc'
	t.title    = @spec.summary
	t.options << '--line-numbers' 
	t.options << '--charset' << 'utf-8'
	t.rdoc_files.include(LICENSE)
	t.rdoc_files.include(README)
	t.rdoc_files.include(CHANGES)
	t.rdoc_files.include('lib/**/*.rb')
end


