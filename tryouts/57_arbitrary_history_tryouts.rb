library :gibbler, File.dirname(__FILE__), '..', 'lib'
library 'gibbler/history', File.dirname(__FILE__), '..', 'lib'

group "History"

Gibbler.enable_debug if Tryouts.verbose > 3



tryouts "Arbitrary Object History" do
  
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
    a.gibbler_commit
  end
  
  dream ['4192d4cb59975813f117a51dcd4454ac16df6703', '2c6957aa1e734d2a3a71caf569a7461a3bf26f11']
  drill "return a FullHouse history" do
    a = FullHouse.new
    a.gibbler_commit
    a.roles = [:jesse]
    a.gibbler_commit
    a.gibbler_history
  end
  
  dream '4192d4cb59975813f117a51dcd4454ac16df6703'
  drill "can revert FullHouse" do
    a = FullHouse.new
    stash :original, a.gibbler_commit
    a.roles = [:jesse]
    stash :updated, a.gibbler
    a.gibbler_revert!
  end
  
end

