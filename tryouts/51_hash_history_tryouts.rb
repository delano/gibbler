

library :gibbler, File.dirname(__FILE__), '..', 'lib'
library 'gibbler/history', File.dirname(__FILE__), '..', 'lib'

group "History"

Gibbler.enable_debug if Tryouts.verbose > 3


tryouts "Hash History" do
  
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
    a[:magic] = :changed
    a.gibble_commit
    a.gibble_revert 'd7049916ddb25e6cc438b1028fb957e5139f9910'
    a
  end
  
  dream Hash[:magic => :original]
  dream :gibble, 'd7049916ddb25e6cc438b1028fb957e5139f9910'
  drill "revert does nothing if gibble is the same as current one" do
    a = { :magic => :original }
    a.gibble_commit
    a.gibble_revert
    a
  end
  
  dream 'd7049916ddb25e6cc438b1028fb957e5139f9910'
  drill "can revert using short gibble" do
    a = { :magic => :original }
    a.gibble_commit
    a[:magic] = :updated
    a.gibble_revert 'd7049916'
  end
  
end
