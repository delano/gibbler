
require 'gibbler'

module Gibbler
  
  module Object
    alias :digest           :gibbler
    alias :changed?         :gibbled?
    alias :digest_fields    :gibbler_fields
    
    # The cache is in the Attic.
    def    digest_cache;     gibbler_cache;  end
  end
  
  #--
  # Aliases for Gibbler::History methods
  #
  # NOTE: we explicitly define the methods rather than use "alias"
  # in the event that the require 'gibbler/aliases' appears before
  # require 'gibbler/history' (alias complains about unknown methods)
  #++
  module History
    def history(*args, &b); gibbler_history(*args, &b); end
    def commit; gibbler_commit; end
    def object(*args, &b); gibbler_object(*args, &b); end
    def stamp(*args, &b); gibbler_stamp(*args, &b); end
    def revert!(*args, &b); gibbler_revert!(*args, &b); end
    def history?; gibbler_history?; end
    def valid?(*args, &b); gibbler_valid?(*args, &b); end
    def find_long(*args, &b); gibbler_find_long(*args, &b); end
  end

end
