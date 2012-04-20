require 'gibbler/mixins'
require 'time'

# arbitrary objects can specify instance variables to gibbler
  class ::SimpleTest
    include Gibbler::Simple
    attr_accessor :roles
    attr_accessor :ready
    gibbler :roles
  end
  a = SimpleTest.new
  a.roles = [:jesse, :joey, :danny, :kimmy, :michelle, :dj, :stephanie]
  a.ready = true
  a.gibbler
#=> "b0a659d02e854721f2c865f4eaaae97bfdeda33b"

# arbitrary objects can append more instance variables later on
  class ::SimpleTest
    gibbler :stamp, :ready
    def stamp
      Time.parse('2009-08-25 16:43:53 UTC')
    end
  end
  a = SimpleTest.new
  a.roles = [:jesse, :joey, :danny, :kimmy, :michelle, :dj, :stephanie]
  a.ready = true
  a.gibbler
#=> "5daf07b7aae043d0ea6b079a630e034dad7f5982"
