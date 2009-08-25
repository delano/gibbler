
library :gibbler, 'lib'
group "Gibbler Gazette"

Gibbler.enable_debug if Tryouts.verbose > 3
Gibbler.digest_type = Digest::SHA1

tryouts "Extended object tryouts" do

  dream :gibbler, 'f2b0150c84c5c834406ec9cdec989a0fa938b4ad' 
  drill "true can gibbler", true
  
  dream :gibbler, 'abee839edf5f9c101c505c28987ca35c31c7fc8d' 
  drill "false can gibbler", false
  
  dream :gibbler, '583fb214ec50d2c4a123cc52de0c65e801d13516' 
  drill "TrueClass can gibbler", TrueClass
  
  dream :gibbler, '11f262be475ddf38a25888e9f6ec82f384a7c58b' 
  drill "FalseClass can gibbler", FalseClass
  
  dream :gibbler, '25ac269ae3ef18cdb4143ad02ca315afb5026de9' 
  drill "Class can gibbler", Class
  
  dream :gibbler, '5620e4a8b10ec6830fece61d33f5d3e9a349b4c2' 
  drill "Object can gibbler", Object
  
  dream :gibbler, '083feec632e6cd5347e3fb3c7048365c3a0d710e' 
  drill "Class instance can gibbler", Class.new
  
  dream :gibbler, '7295241e929ffd7cc974cf8d4481291e070937fc' 
  drill "Module can gibbler", Module
  
  dream :gibbler, '6b5a192fd377dfc5c2828a3ad6105b68b6db33d5' 
  drill "Module instance can gibbler", Module.new
  
  dream :gibbler, '8640f7abcbcb80e3825ed827bf36819e26119e16' 
  drill "Proc can gibbler", Proc
  
  dream :gibbler, 'd73ae2a7bc2058b05dbc1952d8abf004167109e0' 
  drill "Range instance (..) can gibbler", 1..100
  
  dream :gibbler, '46c8a7d0163144819c440bf6734a8101cd72c04a' 
  drill "Range instance (...) can gibbler", 1...100
  
  drill "Range (..) doesn't equal range (...)", true do
     ('a'..'e').gibbler != ('a'...'e').gibbler
  end
  
  
  dream :gibbler, '7295241e929ffd7cc974cf8d4481291e070937fc' 
  drill "Module can gibbler", Module

  dream :gibbler, '6b5a192fd377dfc5c2828a3ad6105b68b6db33d5' 
  drill "Module instance can gibbler", Module.new

  dream :gibbler, '25ac269ae3ef18cdb4143ad02ca315afb5026de9' 
  drill "Class can gibbler", Class
  
  
  # NOTE: Digests will not match for Procs between 1.8 and 1.9 b/c:
  # * Proc#arity returns different values
  # * Proc#lambda? does not exist in Ruby 1.8
  if Tryouts.sysinfo.ruby[0..1] == [1, 8]

    dream :gibbler, '129ff20898335147365341f87d4e051af1ae4e43' 
    drill "Proc.new can gibbler", Proc.new() { }

    dream :gibbler, '129ff20898335147365341f87d4e051af1ae4e43' 
    drill "proc can gibbler", proc {}

    dream :gibbler, '129ff20898335147365341f87d4e051af1ae4e43' 
    drill "lambda can gibbler", lambda {}
    
    dream :gibbler, '338c3ef066504967dd544cd73994c81071f94c94' 
    drill "lambda gibbler is aware of arity", lambda { |v| }
    
    dream :gibbler, '338c3ef066504967dd544cd73994c81071f94c94' 
    drill "proc gibbler is aware of arity", proc { |v| }
  else

    dream :gibbler, '9aaaa4dd6c8df16f71e679f18687645359a6db16' 
    drill "Proc.new can gibbler", Proc.new() { }

    dream :gibbler, '9aaaa4dd6c8df16f71e679f18687645359a6db16' 
    drill "proc can gibbler", proc {}

    dream :gibbler, 'f240cb3b0bc3b4469271de03596acfeb74062597' 
    drill "lambda can gibbler", lambda {}
    
    dream :gibbler, 'e6371b83695c2b3c24f61c212ab6b8424880d7ef' 
    drill "lambda gibbler is aware of arity", lambda { |v| }
    
    dream :gibbler, '338c3ef066504967dd544cd73994c81071f94c94' 
    drill "proc gibbler is aware of arity", proc { |v| }
    
  end
  
end

