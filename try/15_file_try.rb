require 'tempfile'
require 'gibbler'

@tempfile = "tryouts-9000-awesome.txt"
  
## File can gibbler
  file = File.new(File.join('.', 'CHANGES.txt'))
  file.gibbler
#=>  'c052e87bd0acb7e08c98dad7f8b09b4382a08ef6' 
 
## Gibbler is different for each path
  file1 = File.new(File.join('.', 'CHANGES.txt'))
  file2 = File.new(File.join('.', 'README.rdoc'))
  file1.gibbler == file2.gibbler
#=> false

# TempFile can gibbler
  Tempfile.new('gibbler').respond_to? :gibbler
#=> true

# TempFile digests change
  Tempfile.new('gibbler').gibbler != Tempfile.new('gibbler').gibbler
#=> true

# File doesn't care about file contents
  f = File.open @tempfile, 'w'
  f.puts "World's Finest Number: " << "#{rand}"
  f.close
  File.new(@tempfile).gibbler
#=>  '6d93f752fc23f36bffa5ddf9ee97d04be82efbdb'

## JRuby doesn't like to use File.new with directories
###=>  '92cbcb7de73d7748b28d9e911f461013de34410f' 
### "File gibbler cares about trailing slash (/tmp/)", File.new(__FILE__)

File.unlink @tempfile if File.exists? @tempfile
