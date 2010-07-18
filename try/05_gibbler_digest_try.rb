require 'gibbler'

## has short method
  "kimmy".gibbler.short
#=> Gibbler::Digest.new("c8027100")

# can Gibbler::Digest#short
  Gibbler::Digest.new("1234567890").short
#=> Gibbler::Digest.new("12345678")

# == is strict (only exact matches)
  Gibbler::Digest.new("1234567890") !=  "12345678"
#=> true

# === is relaxed (allows partial matches)
  Gibbler::Digest.new("1234567890") === "12345678"
#=> true

# supports base36 output
  Gibbler::Digest.new("1234567890").base36
#=> 'zx2tc40'

# base36 works on digests too
  "kimmy".gibbler.base36
#=> 'nd2w8270caslmly0ix3s8ruh0y8yjdt'

# base36 digests can be short too
  "kimmy".gibbler.base36.short
#=> 'nd2w8270'

# to_s returns a string and can accept a base
  "kimmy".gibbler.to_s(16)
#=> "kimmy".gibbler.base(16).to_s

# base takes a base
  "kimmy".gibbler.base(17)
#=> '12gaabd69eg5b32gf69a7a021c22g977d4gf46d6'

# to_s can take a base
  "kimmy".gibbler.to_s(36)
#=> "kimmy".gibbler.base36
