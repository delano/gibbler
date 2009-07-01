
library :gibbler, File.dirname(__FILE__), '..', 'lib'
library 'gibbler/history', File.dirname(__FILE__), '..', 'lib'

group "History"

tryouts "Basics" do
  
  dream "d7049916ddb25e6cc438b1028fb957e5139f9910"
  drill "can convert short gibble into long" do
    a = { :magic => :original }
    g = a.gibble_commit.short
      stash :short, g
    a.gibble_find_long g
  end
  
  dream :class, Time
  drill "can return most recent stamp" do
    a = { :magic => :original }
    a.gibble_commit
      stash :hist, a.gibble_history
    a.gibble_stamp
  end
  
  dream ["d7049916ddb25e6cc438b1028fb957e5139f9910", "0b11c377fccd44554a601e5d2b135c46dc1c4cb1"]
  drill "can return history" do
    a = { :magic => :original }
    a.gibble_commit
    a[:magic] = :changed
    a.gibble_commit
    a.gibble_history
  end
  
  dream ["d7049916", "0b11c377"]
  drill "can return history (short)" do
    a = { :magic => :original }
    a.gibble_commit
    a[:magic] = :changed
    a.gibble_commit
    a.gibble_history(:short)
  end
end