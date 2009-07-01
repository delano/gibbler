
library :gibbler, File.dirname(__FILE__), '..', 'lib'
group "Gibbler Gazette"

Gibbler.enable_debug if Tryouts.verbose > 3

tryouts "Basic syntax with SHA1" do
  
  dream :respond_to?, :gibble
  dream :gibble, '52be7494a602d85ff5d8a8ab4ffe7f1b171587df' 
  drill "Symbol can gibble", :kimmy
  
  dream :respond_to?, :gibble
  dream :gibble, 'c8027100ecc54945ab15ddac529230e38b1ba6a1' 
  drill "String can gibble" do
    "kimmy"
  end
  
  drill "String and Symbol return different gibbles", true do
    :kimmy.gibble != "kimmy"
  end
  
  dream :respond_to?, :gibble
  dream :gibble, '25ac269ae3ef18cdb4143ad02ca315afb5026de9' 
  drill "Class can gibble", Class
  
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
  
  drill "doesn't reveal @__gibble__ instance variable", false do
    a = {}
    a.gibble  # We need to gibble first so it sets a value to the instance var
    val = Tryouts.sysinfo.ruby[1] == 9 ? :'@__gibble__' : '@__gibble__'
    a.instance_variables.member? val
  end
  
  
end
