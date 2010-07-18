require 'gibbler'

## true can gibbler
  true.gibbler
#=> 'f2b0150c84c5c834406ec9cdec989a0fa938b4ad' 

# false can gibbler
  false.gibbler
#=> 'abee839edf5f9c101c505c28987ca35c31c7fc8d' 

# TrueClass can gibbler
  TrueClass.gibbler
#=> '583fb214ec50d2c4a123cc52de0c65e801d13516' 

# FalseClass can gibbler
  FalseClass.gibbler
#=> '11f262be475ddf38a25888e9f6ec82f384a7c58b' 

# Class can gibbler
  Class.gibbler
#=> '25ac269ae3ef18cdb4143ad02ca315afb5026de9' 

# Object can gibbler
  Object.gibbler
#=> '5620e4a8b10ec6830fece61d33f5d3e9a349b4c2' 

# Class instance can gibbler
  Class.new.gibbler
#=> '083feec632e6cd5347e3fb3c7048365c3a0d710e' 

# Module can gibbler
  Module.gibbler
#=> '7295241e929ffd7cc974cf8d4481291e070937fc' 

# Module instance can gibbler
  Module.new.gibbler
#=> '6b5a192fd377dfc5c2828a3ad6105b68b6db33d5' 

# Proc can gibbler"
  Proc.gibbler
#=> '8640f7abcbcb80e3825ed827bf36819e26119e16' 

# Range instance (..) can gibbler
  (1..100).gibbler
#=> '5450635218fd16e594976e87abd0955529e28248' 

# Range ... is different than ..
  (1...100).gibbler != (1..100).gibbler
#=> true

# Range instance with Floats can gibbler
  (0.1...1.5).gibbler
#=> '9d3cd5a21c17cfa0b4bb685730bd07994c486ba2' 

# Range instance with one Float can gibbler
  (0.1..1).gibbler
#=> 'c725659ca0f3fa3c9ab807bb2db4b718e2dca042' 

# Range (..) doesn't equal range (...)"
  ('a'..'e').gibbler != ('a'...'e').gibbler
#=> true

# nil has a gibbler
  nil.gibbler
#=> '06fdf26b2a64e90cd35ea9162d9cc48c9f6bb13c'

# Module can gibbler
  Module.gibbler
#=> '7295241e929ffd7cc974cf8d4481291e070937fc' 

# Module instance can gibbler
  Module.new.gibbler
#=> '6b5a192fd377dfc5c2828a3ad6105b68b6db33d5' 

# Class can gibbler
  Class.gibbler
#=> '25ac269ae3ef18cdb4143ad02ca315afb5026de9' 

