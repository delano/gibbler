require 'tempfile'

library :gibbler, 'lib'
group "Gibbler Gazette"

Gibbler.enable_debug if Tryouts.verbose > 3
Gibbler.digest_type = Digest::SHA1

tryouts "File object tryouts" do
  set :tempfile, "tryouts-9000-awesome.txt"
  
  clean do
    File.unlink tempfile if File.exists? tempfile
  end
  
  dream :gibbler, '41c2db79df5679011b73e33400f7632caf525812' 
  drill "File can gibbler", File.new(__FILE__)
  
  dream :gibbler, '4c131b7e5f9e7b841b4501d2d002785d3730ae19' 
  drill "Gibbler is different for each path" do
    path = File.join(File.dirname(__FILE__), '..', 'README.rdoc')
    File.new(File.expand_path(path))
  end
  
  ## JRuby doesn't like to use File.new with directories
  ##dream :gibbler, '92cbcb7de73d7748b28d9e911f461013de34410f' 
  ##drill "File gibbler cares about trailing slash (/tmp/)", File.new(__FILE__)
   
  dream :respond_to?, :gibbler
  drill "TempFile can gibbler", Tempfile.new('gibbler')
  
  drill "TempFile digests change", false do
    Tempfile.new('gibbler').gibbler == Tempfile.new('gibbler').gibbler
  end
  
  dream :gibbler, '6d93f752fc23f36bffa5ddf9ee97d04be82efbdb'
  drill "File doesn't care about file contents" do
    f = File.open tempfile, 'w'
    f.puts "World's Finest Number: " << "#{rand}"
    f.close
    stash :file_contents, File.read(tempfile)
    File.new tempfile
  end
end
