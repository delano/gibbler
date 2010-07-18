require 'gibbler'

## has short method
POOP.gibbler.short
#=> Gibbler::Digest.new("c8027100")

# can Gibbler::Digest#short
Gibbler::Digest.new("1234567890").short
#=> Gibbler::Digest.new("12345678")





# == is strict (only exact matches)
Gibbler::Digest.new("1234567890") == "12345678"
#=> true

# === is relaxed (allows partial matches)
Gibbler::Digest.new("1234567890") === "12345678"
#=> false

__END__

  drill "", true do
    
  end

  dream 'zx2tc40'
  drill "supports base36 output" do
    Gibbler::Digest.new("1234567890").base36
  end
  
  dream 'nd2w8270caslmly0ix3s8ruh0y8yjdt'
  drill "base36 works on digests too" do
    "kimmy".gibbler.base36
  end
  
  dream 'nd2w8270'
  drill "base36 digests can be short too" do
    "kimmy".gibbler.base36.short
  end
  
  drill "to_s returns a string and can accept a base" do
    "kimmy".gibbler.to_s(16) == "kimmy".gibbler.base(16).to_s
  end
  
  dream '12gaabd69eg5b32gf69a7a021c22g977d4gf46d6'
  drill "base takes a base" do
    "kimmy".gibbler.base(17)
  end
  
  drill "to_s can take a base" do
    "kimmy".gibbler.to_s(36) == "kimmy".gibbler.base36
  end
end

