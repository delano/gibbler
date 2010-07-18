require 'gibbler'
require 'gibbler/history'

class String
  include Gibbler::History
end

# "can take a String snapshot"
  a = "kimmy"
  a.gibbler_commit
#=> 'c8027100ecc54945ab15ddac529230e38b1ba6a1'

# "return a String history"
  a = "kimmy"
  a.gibbler_commit
  a << " gibbler"
  a.gibbler_commit
  a.gibbler_history
#=> ['c8027100ecc54945ab15ddac529230e38b1ba6a1', '692c05d3186baf2da36e87b7bc5fe53ef13b902e']

# "can revert String"
  a = "kimmy"
  a.gibbler_commit
  a << " gibbler"
  a.gibbler
  a.gibbler_revert!
#=> 'c8027100ecc54945ab15ddac529230e38b1ba6a1'


