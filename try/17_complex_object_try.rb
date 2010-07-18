
library :gibbler, 'lib'
group "Gibbler Gazette"

Gibbler.enable_debug if Tryouts.verbose > 3
Gibbler.digest_type = Digest::SHA1

tryouts "Complex object tryouts" do
  
  dream :gibbler, "fa5f741275b6b27932537e1946042b0286286e1d"
  drill "arbitrary objects can specify instance variables to gibbler" do
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
    a
  end
  
  dream :gibbler, "fbdce0d97a856e7106bec418d585c914914b8aa5"
  drill "arbitrary objects can append more instance variables later on" do
    class ::FullHouse
      gibbler :stamp, :ready
    end
    a = FullHouse.new
    a.roles = [:jesse, :joey, :danny, :kimmy, :michelle, :dj, :stephanie]
    a.stamp = Time.parse('2009-08-25 16:43:53 UTC')
    a.ready = true
    a
  end
end
