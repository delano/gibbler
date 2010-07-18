require 'gibbler'
require 'gibbler/history'

# "Setup Hash class", Hash do
class ::Hash
  include Gibbler::History
end
end

# "doesn't reveal self.__gibbler_history instance variable", false do
a = {}
a.gibbler  # We need to gibbler first so it sets a value to the instance var
val = Tryouts.sysinfo.ruby[1] == 9 ? :'self.__gibbler_history' : 'self.__gibbler_history'
a.instance_variables.member? val
end

# "can take a Hash snapshot", 'd7049916ddb25e6cc438b1028fb957e5139f9910' do
a = { :magic => :original }
a.gibbler_commit
end

#=> :class, Array
#=> :size, 2
#=> ['d7049916ddb25e6cc438b1028fb957e5139f9910', 'b668098e16d08898532bf3aa33ce2253a3a4150e']
# "return a Hash history" do
a = { :magic => :original }
a.gibbler_commit
a[:magic] = :updated
a.gibbler_commit
a.gibbler_history
end

# "can revert Hash" do
a = { :magic => :original }
a.gibbler_commit
a[:magic] = :updated
a.gibbler_revert!
#=> 'd7049916ddb25e6cc438b1028fb957e5139f9910'

# "knows a valid gibble", true do
a = { :magic => :original }
a.gibbler_commit
a.gibbler_valid? 'd7049916ddb25e6cc438b1028fb957e5139f9910'
#=> true

# "knows an invalid gibble", false do
a = { :magic => :original }
a.gibbler_commit
a.gibbler_valid? '2222222222222222222222222222222222222222'
#=> false

# "can revert to any valid gibble" do
a = { :magic => :original }
a.gibbler_commit
a[:magic] = :updated
a.gibbler_commit
a[:magic] = :changed
a.gibbler_commit
a.gibbler_revert! 'd7049916ddb25e6cc438b1028fb957e5139f9910'
a
#=> Hash[:magic => :original]

#=> Hash[:magic => :original]
#=> :gibbler, 'd7049916ddb25e6cc438b1028fb957e5139f9910'
# "revert does nothing if digest is the same as current one" do
a = { :magic => :original }
a.gibbler_commit
a.gibbler_revert!
a
end

# "can revert using short gibble
a = { :magic => :original }
a.gibbler_commit
a[:magic] = :updated
a.gibbler_revert! 'd7049916'
#=> 'd7049916ddb25e6cc438b1028fb957e5139f9910'

