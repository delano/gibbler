
library :gibbler, File.dirname(__FILE__), '..', 'lib'
library 'gibbler/history', File.dirname(__FILE__), '..', 'lib'

group "History"

Gibbler.enable_debug if Tryouts.verbose > 3


tryouts "Exceptions" do
  
  dream :exception, Gibble::BadGibble
  drill "raises exception when reverting to unknown gibble" do
    a = {}
    a.gibble_commit
    a.gibble_revert '2222222222222222222222222222222222222222'
  end
  
end