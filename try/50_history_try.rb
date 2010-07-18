require 'gibbler'
require 'gibbler/history'

# can convert short digest into long
  a = { :magic => :original }
  g = a.gibbler_commit.short
  a.gibbler_find_long(g)
#=> "d7049916ddb25e6cc438b1028fb957e5139f9910"

# can return most recent stamp
  a = { :magic => :original }
  a.gibbler_commit
  a.gibbler_stamp.class
#=> Time

# can return history
  a = { :magic => :original }
  a.gibbler_commit
  a[:magic] = :changed
  a.gibbler_commit
  a.gibbler_history
#=> ["d7049916ddb25e6cc438b1028fb957e5139f9910", "0b11c377fccd44554a601e5d2b135c46dc1c4cb1"]

# can return history (short)
  a = { :magic => :original }
  a.gibbler_commit
  a[:magic] = :changed
  a.gibbler_commit
  a.gibbler_history(:short)
#=> ["d7049916", "0b11c377"]
