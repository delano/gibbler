
library :gibbler, File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
group "Gibbler Gazette"

tryouts "Basic syntax with SHA1" do
  
  dream :respond_to?, :to_gibble
  dream :to_gibble, '5620e4a8b10ec6830fece61d33f5d3e9a349b4c2' 
  drill "Object", Object
  
  dream :respond_to?, :to_gibble
  dream :to_gibble, '25ac269ae3ef18cdb4143ad02ca315afb5026de9' 
  drill "Class", Class
  
  dream :respond_to?, :to_gibble
  dream :to_gibble, 'c93bfdb675f9b0aae27b8c6660690f88bb6603b5' 
  drill "Hash", Hash 
  
  dream :respond_to?, :to_gibble
  dream :to_gibble, '83c4994bb01eefc06aa267aa99aa12b55696616e' 
  drill "Array", Array
  
  dream :respond_to?, :to_gibble
  dream :to_gibble, '2e124aa78e365a6222bfa0f1c725181ab5d33440' 
  drill "Empty Hash instance", Hash.new
  
  dream :to_gibble, "6a0eace5245ec00306c2a15f652a9d520d49b657"
  drill "Populated Hash instance" do
    {
      :a => [1,2,3, [4,5,6]],
      :b => { :c => Class }
    }
  end
  
  dream :respond_to?, :to_gibble
  dream :to_gibble, '2e124aa78e365a6222bfa0f1c725181ab5d33440' 
  drill "Empty Array instance", Array.new
  
  dream :to_gibble, "213c82119d256e29d0e786cfcc5400c3bb043517"
  drill "Populated Array instance" do
    stash :poop, 11111111
    [1, 222222, :runtime, [2, "three", [Object]]]
  end 
  
  drill "Knows when an Hash has changed" do
    a = {}
    stash :clean, a.clone
    a.to_gibble
    a[:magic] = []
    stash :changed, a.clone
    a.gibbled?
  end
  
end

tryouts "Basic syntax with SHA256" do
  setup do
    Object.gibbler_digest_type = Digest::SHA256
  end
  
  dream :respond_to?, :to_gibble
  dream :to_gibble, '5dbdeb534f4c2fff44fc695453ae2da221cdc38c9e3329b5691aa6542669148c' 
  drill "Object", Object
  
  dream :respond_to?, :to_gibble
  dream :to_gibble, '995b827e46b9169bb6f8f29457f61fca24f88593c99d9660f36ec66e528b32f9' 
  drill "Hash", Hash
end

tryouts "Benchmarks", :benchmark do
  
  drill "Setup variables" do
    @@array = (1..100000).map { rand }
  end
  
  drill("array sort!", :mean, 4, 5) { @@array.dup.sort! }
  drill("array sort", :mean, 3.0, 5)  { @@array.dup.sort }

end
