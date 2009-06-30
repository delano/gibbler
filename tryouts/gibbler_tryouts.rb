
library :gibbler, File.dirname(__FILE__), '..', 'lib'
group "Gibbler Gazette"

tryouts "Basic syntax with SHA1" do
  
  dream :respond_to?, :gibble
  dream :gibble, '5620e4a8b10ec6830fece61d33f5d3e9a349b4c2' 
  xdrill "Object", Object
  
  dream :respond_to?, :gibble
  dream :gibble, '25ac269ae3ef18cdb4143ad02ca315afb5026de9' 
  xdrill "Class", Class
  
  dream :respond_to?, :gibble
  dream :gibble, 'c93bfdb675f9b0aae27b8c6660690f88bb6603b5' 
  drill "Hash", Hash 
  
  dream :respond_to?, :gibble
  dream :gibble, '83c4994bb01eefc06aa267aa99aa12b55696616e' 
  drill "Array", Array
  
  dream :respond_to?, :gibble
  dream :gibble, '2e124aa78e365a6222bfa0f1c725181ab5d33440' 
  drill "Empty Hash instance", Hash.new
  
  dream :gibble, "eb06424859fd665b49ab938669229d3424721a54"
  drill "Populated Hash instance" do
    {
      :a => [1,2,3, [4,5,6]],
      :b => { :c => Class }
    }
  end
  
  dream :respond_to?, :gibble
  dream :gibble, '2e124aa78e365a6222bfa0f1c725181ab5d33440' 
  drill "Empty Array instance", Array.new
  
  dream :gibble, "cb398d1deb081e91e7bf7243a5dd670abe9e23bf"
  drill "Populated Array instance" do
    [1, 222222, :runtime, [2, "three", [Object]]]
  end 
  
  drill "Knows when an Hash has changed" do
    a = {}
    stash :clean, a.clone
    a.gibble 
    a[:magic] = []
    stash :changed, a.clone
    a.gibbled?
  end
  
  dream :gibble, "24ef0a2737a995b233c0891d768862ecf0a3aa5d"
  drill "works on arbitrary objects" do
    class ::House
      include Gibbler::Complex
      attr_accessor :uj

    end
    a = House.new
    a.uj = 1
    a
  end
  
end

tryouts "Basic syntax with SHA256" do
  setup do
    Gibbler.gibbler_digest_type = Digest::SHA256
  end
  
  dream :respond_to?, :gibble
  dream :gibble, '5dbdeb534f4c2fff44fc695453ae2da221cdc38c9e3329b5691aa6542669148c' 
  xdrill "Object", Object
  
  dream :respond_to?, :gibble
  dream :gibble, '995b827e46b9169bb6f8f29457f61fca24f88593c99d9660f36ec66e528b32f9' 
  drill "Hash", Hash
end
