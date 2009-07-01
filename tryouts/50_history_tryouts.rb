
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
end