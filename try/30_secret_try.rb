require 'uri'
require 'gibbler'

# "Can set a sexy global secret
  Gibbler.secret = 'kimmy'.gibbler
  Gibbler.secret
#=> "c8027100ecc54945ab15ddac529230e38b1ba6a1"

# "When the secret is set, digests are different
  'kimmy'.gibbler
#=> "62e645351505cb89a0b06a0f5df8383ea754f71d"

# "When the secret is set, digests are different (again)
  Gibbler.secret = :kimmy.gibbler
  'kimmy'.gibbler
#=> "e5f8a3d8e4a2dc99717984726efc910dab0c18f4"

# "Reset the secret back to nil
  Gibbler.secret = nil
  'kimmy'.gibbler
#=> "c8027100ecc54945ab15ddac529230e38b1ba6a1"
