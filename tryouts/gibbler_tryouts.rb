
library :gibbler, File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))

tryouts "Basic syntax with SHA1" do
  
  dream :gibbler, :respond_to?
  dream '5620e4a8b10ec6830fece61d33f5d3e9a349b4c2', :gibbler 
  drill "Object", Object
  
  dream :gibbler, :respond_to?
  dream '25ac269ae3ef18cdb4143ad02ca315afb5026de9', :gibbler 
  drill "Class", Class
  
  dream :gibbler, :respond_to?
  dream 'c93bfdb675f9b0aae27b8c6660690f88bb6603b5', :gibbler 
  drill "Hash", Hash 
  
  dream :gibbler, :respond_to?
  dream '2e124aa78e365a6222bfa0f1c725181ab5d33440', :gibbler 
  drill "Empty Hash instance", Hash.new
  
  dream :gibbler, :respond_to?
  dream '83c4994bb01eefc06aa267aa99aa12b55696616e', :gibbler 
  drill "Array", Array 
  
  dream :gibbler, :respond_to?
  dream '2e124aa78e365a6222bfa0f1c725181ab5d33440', :gibbler 
  drill "Empty Array instance", Array.new
  
  dream "213c82119d256e29d0e786cfcc5400c3bb043517", :gibbler 
  drill "Populated Array instance" do
    [1, 222222, :runtime, [2, "three", [Object]]]
  end 
  
  dream "6a0eace5245ec00306c2a15f652a9d520d49b657", :gibbler 
  drill "Populated Hash instance" do
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
  drill "Object", Object
  
  dream :gibbler, :respond_to?
  dream '995b827e46b9169bb6f8f29457f61fca24f88593c99d9660f36ec66e528b32f9', :gibbler 
  drill "Hash", Hash
  
end