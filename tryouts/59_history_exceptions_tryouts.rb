
library :gibbler, File.dirname(__FILE__), '..', 'lib'
library 'gibbler/history', File.dirname(__FILE__), '..', 'lib'

group "History"

Gibbler.enable_debug if Tryouts.verbose > 3


tryouts "Exceptions" do
  
  dream :exception, Gibbler::BadDigest
  drill "raises exception when reverting to unknown gibble" do
    a = {}
    a.gibbler_commit
    a.gibbler_revert '2222222222222222222222222222222222222222'
  end
  
  dream :exception, Gibbler::NoHistory
  drill "raises exception when reverting and there's no history" do
    a = []
    a.gibbler_revert
  end
  
  dream :exception, NoMethodError
  drill "raises exception when reverting an unsupported object" do
    :kimmy.gibbler_revert
  end
  
end