require 'gibbler'

# arbitrary objects can specify instance variables to gibbler
  class ::FullHouse
    include Gibbler::Complex
    attr_accessor :roles
    attr_accessor :stamp
    attr_accessor :ready
    gibbler :roles
  end
  a = FullHouse.new
  a.roles = [:jesse, :joey, :danny, :kimmy, :michelle, :dj, :stephanie]
  a.stamp = Time.now
  a.ready = true
  a.gibbler
#=> "fa5f741275b6b27932537e1946042b0286286e1d"

# arbitrary objects can append more instance variables later on
  class ::FullHouse
    gibbler :stamp, :ready
  end
  a = FullHouse.new
  a.roles = [:jesse, :joey, :danny, :kimmy, :michelle, :dj, :stephanie]
  a.stamp = Time.parse('2009-08-25 16:43:53 UTC')
  a.ready = true
  a.gibbler
#=> "fbdce0d97a856e7106bec418d585c914914b8aa5"
