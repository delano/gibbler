
library :gibbler, 'lib'
group "Gibbler Gazette"

Gibbler.enable_debug if Tryouts.verbose > 3

tryouts "Basic syntax with SHA1" do
  
  dream :exception, RuntimeError
  drill "include Gibbler raises exception" do
    a = Class.new
    a.send :include, Gibbler
  end
  
  dream :respond_to?, :gibbler
  dream :gibbler, '52be7494a602d85ff5d8a8ab4ffe7f1b171587df' 
  drill "Symbol can gibbler", :kimmy
  
  dream :respond_to?, :gibbler
  dream :gibbler, 'c8027100ecc54945ab15ddac529230e38b1ba6a1' 
  drill "String can gibbler" do
    "kimmy"
  end
  
  drill "String and Symbol return different digests", true do
    :kimmy.gibbler != "kimmy"
  end
  
  dream :respond_to?, :gibbler
  dream :gibbler, '25ac269ae3ef18cdb4143ad02ca315afb5026de9' 
  drill "Class can gibbler", Class
  
  dream :respond_to?, :gibbler
  dream :gibbler, '4fdcadc66a38feb9c57faf3c5a18d5e76a6d29bf' 
  drill "Empty Hash instance", Hash.new
  
  dream :gibbler, 'a9cad665549bd22a4346fcf602d9d3c3b0482bbe'
  drill "Fixnum instance" do
    1
  end
  
  dream :gibbler, '608256db120251843843bba57e9b2c7adb7342aa'
  drill "Bignum instance" do
    100000000000
  end
  
  dream :gibbler, "1d4b62e1e9f2c097b0cefb6877bf47c2015cdd21"
  drill "Populated Hash instance" do
    {
      :a => [1,2,3, [4,5,6]],
      :b => { :c => Class }
    }
  end
  
  dream :respond_to?, :gibbler
  dream :gibbler, '48fda57c05684c9e5c3259557851943572183a21' 
  drill "Empty Array instance", Array.new
  
  dream :gibbler, "3e1d79d113a409a96a13ca3879fc4c42027aa74b"
  drill "Populated Array instance" do
    [1, 2, :runtime, [3, "four", [Object, true]]]
  end 
  
  drill "Knows when a Hash has not changed", false do
    a = { :magic => true }
    a.gibbler
    a[:magic] = true
    a.gibbled?
  end
  
  drill "Knows when a Hash has changed", true do
    a = { :magic => true }
    a.gibbler
    a[:magic] = false
    a.gibbled?
  end
  
  dream ["667ce086", "92d5f7cd"]
  drill "Symbols digests don't cross streams" do
    a, b = :something, :anything
    a.gibbler
    b.gibbler
    [a.gibbler_cache.short, b.gibbler_cache.short]
  end
  
  dream ["ce0c7694", "c13b2f02"]
  drill "String digests don't cross streams" do
    a, b = 'something', 'anything'
    a.gibbler
    b.gibbler
    [a.gibbler_cache.short, b.gibbler_cache.short]
  end
  
  drill "Symbol has list of attic vars", [:gibbler_cache] do
    Symbol.attic_vars
  end

  drill "String has list of attic vars", [:gibbler_cache] do
    String.attic_vars
  end
  
  drill "Hash has list of attic vars", [:gibbler_cache] do
    Hash.attic_vars
  end
  
  drill "Freezing an object will update the digest", true do
    a = { :a => 1 }
    pre  = a.gibbler; 
    a[:a] = 2 
    post = a.freeze.gibbler
    stash :pre, pre
    stash :post, post
    pre != post && post == a.gibbler_cache
  end
  
  dream :gibbler, "fa5f741275b6b27932537e1946042b0286286e1d"
  drill "works on arbitrary objects" do
    class ::FullHouse
      include Gibbler::Complex
      attr_accessor :roles
    end
    a = FullHouse.new
    a.roles = [:jesse, :joey, :danny, :kimmy, :michelle, :dj, :stephanie]
    a
  end
  
  # TODO: Update for Attic 0.4
  drill "doesn't reveal @__gibbler_digest__ instance variable", false do
    a = {}
    a.gibbler  # We need to gibbler first so it sets a value to the instance var
    val = Tryouts.sysinfo.ruby[1] == 9 ? :'@__gibbler_digest__' : '@__gibbler_digest__'
    stash :ivars, a.instance_variables
    stash :smeths, Gibbler.singleton_methods
    a.instance_variables.member? val
  end
  
  drill "previous digest", 'c8027100ecc54945ab15ddac529230e38b1ba6a1' do
    a = "kimmy"
    a.gibbler
    #stash :methods, a.methods.sort
    #
    #stash :string_methods, String.methods.sort
    #stash :gstring_methods, Gibbler::String.methods.sort
    #stash :class_methods, a.class.methods.sort
    stash :ivars, a.instance_variables
    a.gibbler_cache
  end
  
end




