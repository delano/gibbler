require 'gibbler'
require 'gibbler/history'

class Array
  include Gibbler::History
end

# "can take a Array snapshot"
  a = [:jesse]
  a.gibbler_commit
#=> 'd95fcabb498ae282f356eba63da541e4f72c6efa'

# "return an Array history"
  a = [:jesse]
  a.gibbler_commit
  a << :joey
  a.gibbler_commit
  a.gibbler_history
#=> ['d95fcabb498ae282f356eba63da541e4f72c6efa', 'eebcb2e84e828b1a7207af4d588cf41fd4c6393a']

# "can revert Array"
  a = [:jesse]
  a.gibbler_commit
  a << :joey
  a.gibbler_revert!
#=> 'd95fcabb498ae282f356eba63da541e4f72c6efa'

# Raises exception when no history
  begin
  a = [:jesse]
  a.gibbler_revert!
  rescue Gibbler::NoHistory
    :success
  end
#=> :success