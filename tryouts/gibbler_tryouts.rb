
library :gibbler, File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))

tryouts "Basic syntax with SHA1" do
  
  dream :gibbler, :respond_to?
  dream '5620e4a8b10ec6830fece61d33f5d3e9a349b4c2', :gibbler 
  drill "Object has gibbler", Object
  
  dream :gibbler, :respond_to?
  dream 'c93bfdb675f9b0aae27b8c6660690f88bb6603b5', :gibbler 
  drill "Hash has gibbler", Hash 
  
  dream "10af3c894b4e7ef3b683e0f959e21c66b0ac4523", :gibbler 
  drill "wacky" do
    {
      :a => [1,2,3, [4,5,6]],
      :b => { :c => Class }
    }
  end 
  
  
end

tryouts "Basic syntax with SHA256" do
  setup do
    Object.gibbler_digest_type = Digest::SHA256
  end
  
  dream :gibbler, :respond_to?
  dream '5dbdeb534f4c2fff44fc695453ae2da221cdc38c9e3329b5691aa6542669148c', :gibbler 
  drill "Object has gibbler", Object
  
  dream :gibbler, :respond_to?
  dream '995b827e46b9169bb6f8f29457f61fca24f88593c99d9660f36ec66e528b32f9', :gibbler 
  drill "Hash has gibbler", Hash
  
end