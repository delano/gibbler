require 'gibbler'
require 'gibbler/history'

class ::Hash
  include Gibbler::History
end

## "doesn't reveal self.__gibbler_history instance variable",
  a = {}
  a.gibbler  # We need to gibbler first so it sets a value to the instance var
  val = RUBY_VERSION >= '1.9' ? :'self.__gibbler_history' : 'self.__gibbler_history'
  a.instance_variables.member? val
#=> false

# can take a Hash snapshot
  a = { :magic => :original }
  a.gibbler_commit
#=> 'd7049916ddb25e6cc438b1028fb957e5139f9910'

# "return a Hash history"
  a = { :magic => :original }
  a.gibbler_commit
  a[:magic] = :updated
  a.gibbler_commit
  a.gibbler_history
#=> ['d7049916ddb25e6cc438b1028fb957e5139f9910', 'b668098e16d08898532bf3aa33ce2253a3a4150e']

# "can revert Hash"
  a = { :magic => :original }
  a.gibbler_commit
  a[:magic] = :updated
  a.gibbler_revert!
#=> 'd7049916ddb25e6cc438b1028fb957e5139f9910'

# "knows a valid gibble"
  a = { :magic => :original }
  a.gibbler_commit
  a.gibbler_valid? 'd7049916ddb25e6cc438b1028fb957e5139f9910'
#=> true

# "knows an invalid gibble"
  a = { :magic => :original }
  a.gibbler_commit
  a.gibbler_valid? '2222222222222222222222222222222222222222'
#=> false

# "can revert to any valid gibble"
  a = { :magic => :original }
  a.gibbler_commit
  a[:magic] = :updated
  a.gibbler_commit
  a[:magic] = :changed
  a.gibbler_commit
  a.gibbler_revert! 'd7049916ddb25e6cc438b1028fb957e5139f9910'
  a
#=> Hash[:magic => :original]

# "revert does nothing if digest is the same as current one"
  a = { :magic => :original }
  a.gibbler_commit
  a.gibbler_revert!
  a
#=> Hash[:magic => :original]

# "can revert using short gibbler_commit"
  a = { :magic => :original }
  a.gibbler_commit
  a[:magic] = :updated
  a.gibbler_revert! 'd7049916'
#=> 'd7049916ddb25e6cc438b1028fb957e5139f9910'

