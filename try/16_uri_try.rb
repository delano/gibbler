require 'uri'

library :gibbler, 'lib'
group "Gibbler Gazette"

Gibbler.enable_debug if Tryouts.verbose > 3
Gibbler.digest_type = Digest::SHA1

tryouts "URI object tryouts" do
  
  dream :gibbler, "9efe60a5db66aecf9b5fb8655b0bab0fcc7bd0c5"
  drill "URI::HTTP can gibbler" do
    uri = URI.parse "http://localhost:3114/spaceship"
    uri
  end
  
  dream :gibbler, "b75d3c34e60d6feafa796ddbb51e45710f6b106d"
  drill "URI::HTTPS can gibbler" do
    uri = URI.parse "https://localhost:3114/spaceship"
    uri
  end
  
  dream :gibbler, "191b0072b95ca0c79ed75e6deb5b28562dd9e5b9"
  drill "URI::HTTP is trailing slash sensitive" do
    uri = URI.parse "http://localhost:3114/spaceship/"
    uri
  end
  
  dream :gibbler, "d378372934326947113489d1f36f4853bef90a65"
  drill "URI::Generic can gibbler" do
    uri = URI.parse "localhost:3114/spaceship"
    uri
  end
  
  dream :gibbler, "9d0543b31afebac9e8d38c56a0cf12070779f790"
  drill "URI::FTP can gibbler" do
    uri = URI.parse "ftp://localhost:3114/spaceship"
    uri
  end
  
end
