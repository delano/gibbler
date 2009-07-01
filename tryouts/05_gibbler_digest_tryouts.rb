
library :gibbler, 'lib'

group "Gibbler::Digest"

tryouts "All methods" do
  
  
  dream :class, Gibbler::Digest
  dream 'c8027100'  
  drill "has short method" do
    "kimmy".gibbler.short
  end
  
  dream :class, Gibbler::Digest
  dream "12345678"
  drill "can Gibbler::Digest#short" do
    Gibbler::Digest.new("1234567890").short
  end
  
  drill "can return true if compared with short", true do
    Gibbler::Digest.new("1234567890") == "12345678"
  end
  
end

