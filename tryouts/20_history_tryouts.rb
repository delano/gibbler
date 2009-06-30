
library :gibbler, File.dirname(__FILE__), '..', 'lib'
group "Gibbler Gazette"

Gibbler.enable_debug if Tryouts.verbose > 3


tryouts "History" do
  
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
