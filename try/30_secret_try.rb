require 'uri'

library :gibbler, 'lib'
group "Gibbler Gazette"

Gibbler.enable_debug if Tryouts.verbose > 3
Gibbler.digest_type = Digest::SHA1

tryouts "Global secrets" do
  
  dream "c8027100ecc54945ab15ddac529230e38b1ba6a1"
  drill "Can set a global secret" do
    Gibbler.secret = 'kimmy'.gibbler
    Gibbler.secret
  end
  
  dream "62e645351505cb89a0b06a0f5df8383ea754f71d"
  drill "When the secret is set, digests are different" do
    'kimmy'.gibbler
  end
  
  dream "e5f8a3d8e4a2dc99717984726efc910dab0c18f4"
  drill "When the secret is set, digests are different (again)" do
    Gibbler.secret = :kimmy.gibbler
    'kimmy'.gibbler
  end
  
  dream "c8027100ecc54945ab15ddac529230e38b1ba6a1"
  drill "Reset the secret back to nil" do
    Gibbler.secret = nil
    'kimmy'.gibbler
  end
  
end
