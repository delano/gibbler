
group "Aliases"

library :gibbler, 'lib'
library 'gibbler/aliases', 'lib'
library 'gibbler/history', 'lib'

tryouts "Gibbler::Object Aliases" do
  
  drill "has digest", true do
    :kimmy.gibbler == :kimmy.digest
  end
  
  drill "has changed?", true do
    a = "kimmy"
    a.digest
    a << '+ dj'
    a.gibbled?
  end
  
end


tryouts "Gibbler::History Aliases" do
  
  dream "d7049916ddb25e6cc438b1028fb957e5139f9910"
  drill "can convert short digest into long" do
    a = { :magic => :original }
    g = a.commit.short
      stash :short, g
    a.find_long g
  end
  
  dream :class, Time
  drill "can return most recent stamp" do
    a = { :magic => :original }
    a.commit
      stash :hist, a.history
    a.stamp
  end
  
  dream ["d7049916ddb25e6cc438b1028fb957e5139f9910", "0b11c377fccd44554a601e5d2b135c46dc1c4cb1"]
  drill "can return history" do
    a = { :magic => :original }
    a.commit
    a[:magic] = :changed
    a.commit
    a.history
  end
  
  dream ["d7049916", "0b11c377"]
  drill "can return history (short)" do
    a = { :magic => :original }
    a.commit
    a[:magic] = :changed
    a.commit
    a.history(:short)
  end
  
end