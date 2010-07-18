require 'gibbler'

## Gibbler Objects have gibbler_cache method
  "kimmy".respond_to? :gibbler_cache
#=> true

## Gibbler Objects have __gibbler_cache method
  "kimmy".respond_to? :__gibbler_cache
#=> true

## __gibbler_cache returns the same value as gibbler_cache
  @a = "kimmy" and @a.gibbler
  @a.gibbler_cache
#=> @a.__gibbler_cache
