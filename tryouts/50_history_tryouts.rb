
library :gibbler, File.dirname(__FILE__), '..', 'lib'
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
    a.gibble_snapshot
  end
  
  dream :class, Array
  dream :size, 2
  dream ['d7049916ddb25e6cc438b1028fb957e5139f9910', 'b668098e16d08898532bf3aa33ce2253a3a4150e']
  drill "return a Hash history" do
    a = { :magic => :original }
    a.gibble_snapshot
    a[:magic] = :updated
    a.gibble_snapshot
    a.gibble_history
  end
  
  dream 'd7049916ddb25e6cc438b1028fb957e5139f9910'
  drill "can revert Hash" do
    a = { :magic => :original }
    a.gibble_snapshot
    a[:magic] = :updated
    a.gibble_revert
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
    a.gibble_snapshot
  end
  
  dream :class, Array
  dream :size, 2
  dream ['d95fcabb498ae282f356eba63da541e4f72c6efa', 'eebcb2e84e828b1a7207af4d588cf41fd4c6393a']
  drill "return an Array history" do
    a = [:jesse]
    a.gibble_snapshot
    a << :joey
    a.gibble_snapshot
    a.gibble_history
  end
  
  dream 'd95fcabb498ae282f356eba63da541e4f72c6efa'
  drill "can revert Array" do
    a = [:jesse]
    stash :original, a.gibble_snapshot
    a << :joey
    stash :updated, a.gibble
    a.gibble_revert
  end
  
  
end


