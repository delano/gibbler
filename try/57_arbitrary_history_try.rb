require 'gibbler'
require 'gibbler/history'

class ::FullHouse
  include Gibbler::Complex
  include Gibbler::History
  attr_accessor :roles
end

# "can take a FullHouse snapshot"
  a = FullHouse.new
  a.gibbler_commit
#=> '4192d4cb59975813f117a51dcd4454ac16df6703'

# "return a FullHouse history"
  a = FullHouse.new
  a.gibbler_commit
  a.roles = [:jesse]
  a.gibbler_commit
  a.gibbler_history
#=> ['4192d4cb59975813f117a51dcd4454ac16df6703', '05219bdee8ec6300b579f2ba8ce55d851d10928b']

# "can revert FullHouse"
  a = FullHouse.new
  a.gibbler_commit
  a.roles = [:jesse]
  a.gibbler
  a.gibbler_revert!
#=> '4192d4cb59975813f117a51dcd4454ac16df6703'


