require 'gibbler/aliases'
require 'gibbler/history'


# "has digest"
  :kimmy.gibbler == :kimmy.digest
#=> true
  
# "has digest_cache", true
  a = :kimmy.gibbler
  a.gibbler_cache == a.digest_cache
#=> true
  
# "has changed?"
  a = "kimmy"
  a.digest
  a << '+ dj'
  a.gibbled?
#=> true

# "can convert short digest into long"
  a = { :magic => :original }
  g = a.commit.short
  a.find_long g
#=> "d7049916ddb25e6cc438b1028fb957e5139f9910"

# "can return most recent stamp"
  a = { :magic => :original }
  a.commit
  a.stamp.class
#=> Time

# "can return history"
  a = { :magic => :original }
  a.commit
  a[:magic] = :changed
  a.commit
  a.history
#=> ["d7049916ddb25e6cc438b1028fb957e5139f9910", "0b11c377fccd44554a601e5d2b135c46dc1c4cb1"]

# "can return history (short)"
  a = { :magic => :original }
  a.commit
  a[:magic] = :changed
  a.commit
  a.history(:short)
#=> ["d7049916", "0b11c377"]
