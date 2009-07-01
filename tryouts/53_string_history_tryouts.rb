library :gibbler, File.dirname(__FILE__), '..', 'lib'
library 'gibbler/history', File.dirname(__FILE__), '..', 'lib'

group "History"

Gibbler.enable_debug if Tryouts.verbose > 3


tryouts "String History" do
  
  drill "Setup String class", String do
    class ::String
      include Gibbler::History
    end
  end
  
  drill "can take a String snapshot", 'c8027100ecc54945ab15ddac529230e38b1ba6a1' do
    a = "kimmy"
    a.gibbler_commit
  end
  
  dream :class, Array
  dream :size, 2
  dream ['c8027100ecc54945ab15ddac529230e38b1ba6a1', '692c05d3186baf2da36e87b7bc5fe53ef13b902e']
  drill "return a String history" do
    a = "kimmy"
    a.gibbler_commit
    a << " gibbler"
    a.gibbler_commit
    a.gibbler_history
  end
  
  dream 'c8027100ecc54945ab15ddac529230e38b1ba6a1'
  drill "can revert String" do
    a = "kimmy"
    stash :original, a.gibbler_commit
    a << " gibbler"
    stash :updated, a.gibbler
    a.gibbler_revert
  end
  
end

