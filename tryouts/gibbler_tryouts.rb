
library :gibbler, File.dirname(__FILE__), '..', 'lib'
group "Gibbler Gazette"

tryouts "Basic syntax with SHA1" do
  
  dream :respond_to?, :gibble
  dream :gibble, '92d5f7cd308925bfb38b05e60ba2e4cc58b3807e' 
  drill "Symbol", :anything
  
  dream :respond_to?, :gibble
  dream :gibble, '25ac269ae3ef18cdb4143ad02ca315afb5026de9' 
  drill "Class", Class
  
  dream :respond_to?, :gibble
  dream :gibble, '2e124aa78e365a6222bfa0f1c725181ab5d33440' 
  drill "Empty Hash instance", Hash.new
  
  dream :gibble, 'a9cad665549bd22a4346fcf602d9d3c3b0482bbe'
  drill "Fixnum instance" do
    1
  end
  
  dream :gibble, '259afadb4ef8abaeb367db97d0c3015c8a4a504a'
  drill "Bignum instance" do
    100000000000
  end
  
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
  
  dream :gibble, "8f3615b8e22ee9c6caac00d31527adb37904f38d"
  drill "works on arbitrary objects" do
    class ::FullHouse
      include Gibbler::Complex
      attr_accessor :actors
    end
    a = FullHouse.new
    a.actors = [:jesse, :joey, :danny]
    a
  end
  

  
end

tryouts "Basic syntax with SHA256" do
  setup do
    Gibbler.gibbler_digest_type = Digest::SHA256
  end
  
  dream :respond_to?, :gibble
  dream :gibble, '754f87ca720ec256633a286d9270d68478850b2abd7b0ae65021cb769ae70c08' 
  drill "Symbol", :anything
  
  dream :respond_to?, :gibble
  dream :gibble, 'd345c0afb4e8da0133a3946d3bd9b2622b0acdd8d6cc1237470cc637a9e4777f' 
  drill "Class", Class
  
  dream :respond_to?, :gibble
  dream :gibble, '91e0dc8b5132520064d037ef4c5a12781a02febedd1980e27e5f25e3eb56e70c' 
  drill "Hash", {}
  
end
