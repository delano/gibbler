
library :gibbler, File.dirname(__FILE__), '..', 'lib'
library 'gibbler/history', File.dirname(__FILE__), '..', 'lib'

group "History"

Gibbler.enable_debug if Tryouts.verbose > 3


tryouts "Array History" do
  
  drill "Setup Array class", Array do
    class ::Array
      include Gibbler::History
    end
  end
  
  drill "can take a Array snapshot", 'd95fcabb498ae282f356eba63da541e4f72c6efa' do
    a = [:jesse]
    a.gibble_commit
  end
  
  dream :class, Array
  dream :size, 2
  dream ['d95fcabb498ae282f356eba63da541e4f72c6efa', 'eebcb2e84e828b1a7207af4d588cf41fd4c6393a']
  drill "return an Array history" do
    a = [:jesse]
    a.gibble_commit
    a << :joey
    a.gibble_commit
    a.gibble_history
  end
  
  dream 'd95fcabb498ae282f356eba63da541e4f72c6efa'
  drill "can revert Array" do
    a = [:jesse]
    stash :original, a.gibble_commit
    a << :joey
    stash :updated, a.gibble
    a.gibble_revert
  end
  
  
end
