
library :gibbler, 'lib'
group "Gibbler Gazette"

Gibbler.enable_debug if Tryouts.verbose > 3
Gibbler.digest_type = Digest::SHA1

tryouts "Extended object tryouts" do

  dream :gibbler, 'f2b0150c84c5c834406ec9cdec989a0fa938b4ad' 
  drill "true can gibbler", true
  
  dream :gibbler, 'abee839edf5f9c101c505c28987ca35c31c7fc8d' 
  drill "false can gibbler", false
  
  dream :gibbler, 'c688e148af1d223425cb63e55501df98cee44ee3' 
  drill "TrueClass can gibbler", TrueClass
  
  dream :gibbler, 'db109226e95cc484f22437025a764ab0fae3ff8d' 
  drill "FalseClass can gibbler", FalseClass
  
  dream :gibbler, 'cd114c32b2137909505af243ed9ecba3600cc5fd' 
  drill "Class can gibbler", Class
  
  dream :gibbler, 'da23a14fc54b12b8fe8f747f51b2917d5d05e0ad' 
  drill "Class instance can gibbler", Class.new
  
  dream :gibbler, '8e145e26e5dc06688f9ee4411a43b08d2e7ed4fa' 
  drill "Module can gibbler", Module
  
  dream :gibbler, '2dad58a8975d62f9c6e41c5d1efd9c2adef84d6a' 
  drill "Module instance can gibbler", Module.new
  
  dream :gibbler, '6b7978dae078bf62eb4082f2447bb81919ffc596' 
  drill "Proc can gibbler", Proc
  
  
#  dream :gibbler, '7295241e929ffd7cc974cf8d4481291e070937fc22' 
#  drill "Module can gibbler", Module

#  dream :gibbler, '7295241e929ffd7cc974cf8d4481291e070937fc' 
#  drill "Module instance can gibbler", Module.new

#  dream :gibbler, '25ac269ae3ef18cdb4143ad02ca315afb5026de9' 
#  drill "Class can gibbler", Class
  
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

p 