
library :gibbler, 'lib'

group "Gibbler::Digest"

tryouts "Backwards compatability" do
  
  dream true
  drill "Gibbler Objects have gibbler_cache method" do
    "kimmy".respond_to? :gibbler_cache
  end
  
  dream true
  drill "Gibbler Objects have __gibbler_cache method" do
    "kimmy".respond_to? :__gibbler_cache
  end
  
  dream true
  drill "__gibbler_cache returns the same value as gibbler_cache" do
    a = "kimmy" and a.gibbler
    a.__gibbler_cache == a.gibbler_cache
  end

end

