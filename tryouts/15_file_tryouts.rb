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
  
  dream :gibbler, 'c8bc8b3a4e15c634eabe0742b2aba1b43b11b5b6' 
  drill "File.new('.')", File.new('.')
  
  dream :gibbler, '3af85a191366499641ce76438751ea8e64c5f5fd' 
  drill "File gibbler is different for each path (/tmp)", File.new('/tmp')
  
  dream :gibbler, '92cbcb7de73d7748b28d9e911f461013de34410f' 
  drill "File gibbler cares about trailing slash (/tmp/)", File.new('/tmp/')
   
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
