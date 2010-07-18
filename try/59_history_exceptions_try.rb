require 'gibbler'
require 'gibbler/history'


# "raises exception when reverting to unknown gibble"
  begin
    a = {}
    a.gibbler_commit
    a.gibbler_revert! '2222222222222222222222222222222222222222'
  rescue Gibbler::BadDigest
    :success
  end
#=> :success

# "raises exception when reverting and there's no history"
  begin
    a = []
    a.gibbler_revert!
  rescue Gibbler::NoHistory
    :success
  end
#=> :success

# "raises exception when reverting an unsupported object"
  begin
    :kimmy.gibbler_revert!
  rescue NoMethodError
    :success
  end
#=> :success

