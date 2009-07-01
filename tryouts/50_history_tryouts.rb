
library :gibbler, File.dirname(__FILE__), '..', 'lib'
library 'gibbler/history', File.dirname(__FILE__), '..', 'lib'

group "Gibbler Gazette"

Gibbler.enable_debug if Tryouts.verbose > 3


tryouts "History (Hash)" do
  
  drill "Setup Hash class", Hash do
    class ::Hash
      include Gibbler::History
    end
  end
  
  drill "doesn't reveal @__gibbles__ instance variable", false do
    a = {}
    a.gibble  # We need to gibble first so it sets a value to the instance var
    val = Tryouts.sysinfo.ruby[1] == 9 ? :'@__gibbles__' : '@__gibbles__'
    a.instance_variables.member? val
  end
  
  drill "can take a Hash snapshot", 'd7049916ddb25e6cc438b1028fb957e5139f9910' do
    a = { :magic => :original }
    a.gibble_commit
  end
  
  dream :class, Array
  dream :size, 2
  dream ['d7049916ddb25e6cc438b1028fb957e5139f9910', 'b668098e16d08898532bf3aa33ce2253a3a4150e']
  drill "return a Hash history" do
    a = { :magic => :original }
    a.gibble_commit
    a[:magic] = :updated
    a.gibble_commit
    a.gibble_history
  end
  
  dream 'd7049916ddb25e6cc438b1028fb957e5139f9910'
  drill "can revert Hash" do
    a = { :magic => :original }
    a.gibble_commit
    a[:magic] = :updated
    a.gibble_revert
  end
  
  drill "knows a valid gibble", true do
    a = { :magic => :original }
    a.gibble_commit
    a.gibble_valid? 'd7049916ddb25e6cc438b1028fb957e5139f9910'
  end
  
  drill "knows an invalid gibble", false do
    a = { :magic => :original }
    a.gibble_commit
    a.gibble_valid? '2222222222222222222222222222222222222222'
  end
  
  dream Hash[:magic => :original]
  drill "can revert to any valid gibble" do
    a = { :magic => :original }
    a.gibble_commit
    a[:magic] = :updated
    a.gibble_commit
    a[:magic] = :updated2
    a.gibble_commit
    a.gibble_revert 'd7049916ddb25e6cc438b1028fb957e5139f9910'
    a
  end
  
  dream :exception, Gibble::BadGibble
  drill "raises exception when reverting to invalid gibble" do
    a = {}
    a.gibble_commit
    a.gibble_revert '2222222222222222222222222222222222222222'
  end
  
  
end

tryouts "History (Array)" do
  
  drill "Setup Array class", Array do
    class ::Array
      include Gibbler::History
    end
  end
  
  drill "can take a Array snapshot", 'd95fcabb498ae282f356eba63da541e4f72c6efa' do
    a = [:jesse]
    a.gibble_commit
  end
  
  dream :class, Array
  dream :size, 2
  dream ['d95fcabb498ae282f356eba63da541e4f72c6efa', 'eebcb2e84e828b1a7207af4d588cf41fd4c6393a']
  drill "return an Array history" do
    a = [:jesse]
    a.gibble_commit
    a << :joey
    a.gibble_commit
    a.gibble_history
  end
  
  dream 'd95fcabb498ae282f356eba63da541e4f72c6efa'
  drill "can revert Array" do
    a = [:jesse]
    stash :original, a.gibble_commit
    a << :joey
    stash :updated, a.gibble
    a.gibble_revert
  end
  
  
end

tryouts "History (String)" do
  
  drill "Setup String class", String do
    class ::String
      include Gibbler::History
    end
  end
  
  drill "can take a String snapshot", 'c8027100ecc54945ab15ddac529230e38b1ba6a1' do
    a = "kimmy"
    a.gibble_commit
  end
  
  dream :class, Array
  dream :size, 2
  dream ['c8027100ecc54945ab15ddac529230e38b1ba6a1', '692c05d3186baf2da36e87b7bc5fe53ef13b902e']
  drill "return a String history" do
    a = "kimmy"
    a.gibble_commit
    a << " gibbler"
    a.gibble_commit
    a.gibble_history
  end
  
  dream 'c8027100ecc54945ab15ddac529230e38b1ba6a1'
  drill "can revert String" do
    a = "kimmy"
    stash :original, a.gibble_commit
    a << " gibbler"
    stash :updated, a.gibble
    a.gibble_revert
  end
  
end

tryouts "History (abitrary objects)" do
  
  drill "Setup String class", 'FullHouse' do
    class ::FullHouse
      include Gibbler::Complex
      include Gibbler::History
      attr_accessor :roles
    end
    FullHouse.to_s
  end
  
  drill "can take a FullHouse snapshot", '4192d4cb59975813f117a51dcd4454ac16df6703' do
    a = FullHouse.new
    a.gibble_commit
  end
  
  dream ['4192d4cb59975813f117a51dcd4454ac16df6703', '2c6957aa1e734d2a3a71caf569a7461a3bf26f11']
  drill "return a FullHouse history" do
    a = FullHouse.new
    a.gibble_commit
    a.roles = [:jesse]
    a.gibble_commit
    a.gibble_history
  end
  
  dream '4192d4cb59975813f117a51dcd4454ac16df6703'
  drill "can revert FullHouse" do
    a = FullHouse.new
    stash :original, a.gibble_commit
    a.roles = [:jesse]
    stash :updated, a.gibble
    a.gibble_revert
  end
  
end
