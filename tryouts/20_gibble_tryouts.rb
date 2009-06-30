
library :gibbler, File.dirname(__FILE__), '..', 'lib'
group "Gibbler Gazette"

Gibbler.enable_debug if Tryouts.verbose > 3


tryouts "Gibble object" do
  
  dream :class, Gibble
  dream 'c8027100'  
  drill "has short method" do
    "kimmy".gibble.short
  end
  
end
