require 'uri'
require 'gibbler'

# "URI::HTTP can gibbler"
  uri = URI.parse "http://localhost:3114/spaceship"
  uri.gibbler
#=> "9efe60a5db66aecf9b5fb8655b0bab0fcc7bd0c5"

# "URI::HTTPS can gibbler"
  uri = URI.parse "https://localhost:3114/spaceship"
  uri.gibbler
#=> "b75d3c34e60d6feafa796ddbb51e45710f6b106d"

# "URI::HTTP is trailing slash sensitive"
  uri = URI.parse "http://localhost:3114/spaceship/"
  uri.gibbler
#=> "191b0072b95ca0c79ed75e6deb5b28562dd9e5b9"

# "URI::Generic can gibbler"
  uri = URI.parse "localhost:3114/spaceship"
  uri.gibbler
#=> "d378372934326947113489d1f36f4853bef90a65"

# "URI::FTP can gibbler"
  uri = URI.parse "ftp://localhost:3114/spaceship"
  uri.gibbler
#=> "9d0543b31afebac9e8d38c56a0cf12070779f790"

