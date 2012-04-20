require 'gibbler'

## Create a digest from flattened Array
Gibbler.digest [1, :sym, ['string', 2,3]].flatten.join(':')
#=> 'd84d6ad2bd5c9589842fb02cf3c384e4924b1d3f'

## Create a digest from Array
Gibbler.digest [1, :sym, ['string', 2,3]]
#=> 'd84d6ad2bd5c9589842fb02cf3c384e4924b1d3f'

## Create an instance
Gibbler.new 1, :sym, 'string', 2,3
#=> 'd84d6ad2bd5c9589842fb02cf3c384e4924b1d3f'

## Can modify base
g = Gibbler.new 1, :sym, 'string', 2,3
g.base(36)
#=> 'p9lffkbfkgpf7j71ho5cvxxcvx8gv27'

## Maintains class
g = Gibbler.new 1, :sym, 'string', 2,3
g.base(36).class
#=> Gibbler

## Can change digest type
if Tryouts.sysinfo.vm == :java 
  require 'openssl'
  Gibbler.digest_type = OpenSSL::Digest::SHA256
else
  Gibbler.digest_type = Digest::SHA256
end
g = Gibbler.new 1, :sym, 'string', 2,3
#=> '204aacebb816bc2c8675f3490bf5a1a908988fb72f3dfd6774e963bbb9e26a26'

Gibbler.digest_type = Digest::SHA1