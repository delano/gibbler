
library :gibbler, 'lib'
group "Gibbler Gazette"

Gibbler.enable_debug if Tryouts.verbose > 3
Gibbler.digest_type = Digest::SHA1

tryouts "Regexp objects" do
  
  dream :gibbler, "664f7051523ada6f51d42ccbf110eb6dd5102ea7"
  drill "Regexp can gibbler" do
    a = /^\/(?:[-_.!~*'()a-zA-Z\d:@&=+$,]|%[a-fA-F\d]{2})$/im
    
  end
  
end