
library :gibbler, 'lib'

group "Gibble"

tryouts "All methods" do
  
  dream :class, Gibble
  dream "12345678"
  drill "can Gibble#short" do
    Gibble.new("1234567890").short
  end
  
  drill "can return true if compared with short", true do
    Gibble.new("1234567890") == "12345678"
  end
  
end

