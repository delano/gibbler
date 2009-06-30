
library :gibbler, File.dirname(__FILE__), '..', 'lib'
group "Gibbler Gazette"


Gibbler.enable_debug if Tryouts.verbose > 3

tryouts "Basic syntax with SHA1" do
  
  dream :respond_to?, :gibble
  dream :gibble, '92d5f7cd308925bfb38b05e60ba2e4cc58b3807e' 
  drill "Symbol", :anything
  
  dream :respond_to?, :gibble
  dream :gibble, '25ac269ae3ef18cdb4143ad02ca315afb5026de9' 
  drill "Class", Class
  
  dream :respond_to?, :gibble
  dream :gibble, '4fdcadc66a38feb9c57faf3c5a18d5e76a6d29bf' 
  drill "Empty Hash instance", Hash.new
  
  dream :gibble, 'a9cad665549bd22a4346fcf602d9d3c3b0482bbe'
  drill "Fixnum instance" do
    1
  end
  
  dream :gibble, '259afadb4ef8abaeb367db97d0c3015c8a4a504a'
  drill "Bignum instance" do
    100000000000
  end
  
  dream :gibble, "1d4b62e1e9f2c097b0cefb6877bf47c2015cdd21"
  drill "Populated Hash instance" do
    {
      :a => [1,2,3, [4,5,6]],
      :b => { :c => Class }
    }
  end
  
  dream :respond_to?, :gibble
  dream :gibble, '48fda57c05684c9e5c3259557851943572183a21' 
  drill "Empty Array instance", Array.new
  
  dream :gibble, "884e5713aa70468333459f80aea1bb05394ca4ba"
  drill "Populated Array instance" do
    [1, 22222222222, :runtime, [2, "three", [Object, true]]]
  end 
  
  drill "Knows when a Hash has not changed", false do
    a = { :magic => true }
    a.gibble
    a[:magic] = true
    a.gibbled?
  end
  
  drill "Knows when a Hash has changed", true do
    a = { :magic => true }
    a.gibble
    a[:magic] = false
    a.gibbled?
  end
  
  dream :gibble, "6ea546919dc4caa2bab69799b71d48810a1b48fa"
  drill "works on arbitrary objects" do
    class ::FullHouse
      include Gibbler::Complex
      attr_accessor :roles
    end
    a = FullHouse.new
    a.roles = [:jesse, :joey, :danny, :kimmy, :michelle, :dj, :stephanie]
    a
  end
  

  
end

tryouts "Basic syntax with SHA256" do
  setup do
    Gibbler.digest_type = Digest::SHA256
  end
  
  dream :respond_to?, :gibble
  dream :gibble, '754f87ca720ec256633a286d9270d68478850b2abd7b0ae65021cb769ae70c08' 
  drill "Symbol", :anything
  
  dream :respond_to?, :gibble
  dream :gibble, 'd345c0afb4e8da0133a3946d3bd9b2622b0acdd8d6cc1237470cc637a9e4777f' 
  drill "Class", Class
  
  dream :respond_to?, :gibble
  dream :gibble, '88d2bcbd68ce593fd2e0e06f276f7301357516291b95c0c53038e61a9bf091e5' 
  drill "Empty Hash instance", {}
  
end
