

module Gibbler
  
  module Object
    
    def self.included(obj)
      obj.extend Attic
      obj.attic :gibbler_cache
      # Backwards compatibility for <= 0.6.2 
      obj.send :alias_method, :__gibbler_cache, :gibbler_cache
    end
    
    # Calculates a digest for the current object instance. 
    # Objects that are a kind of Hash or Array are processed
    # recursively. The length of the returned String depends 
    # on the digest type. Also stores the value in the attic.
    # 
    #     obj.gibbler          # => a5b1191a
    #     obj.gibbler_cache    # => a5b1191a
    # 
    # Calling gibbler_cache returns the most recent digest
    # without calculation.
    #
    # If the object is frozen, this will return the value of
    # <tt>gibbler_cache</tt>.
    #
    def gibbler
      gibbler_debug :GIBBLER, self.class, self
      return self.gibbler_cache if self.frozen?
      self.gibbler_cache = Gibbler::Digest.new self.__gibbler
    end

    # Has this object been modified?
    #
    # This method compares the return value from digest with the 
    # previous value returned by gibbler (the value is stored in
    # the attic as <tt>gibbler_cache</tt>).
    # See Attic[http://github.com/delano/attic]
    def gibbled?
      self.gibbler_cache ||= self.gibbler
      was, now = self.gibbler_cache.clone, self.gibbler
      gibbler_debug :gibbled?, was, now
      was != now
    end

    def gibbler_debug(*args)
      return unless Gibbler.debug?
      p args
    end
    
    # Creates a digest for the current state of self based on:
    # * Object#class
    # * Length of Object#name || ''
    # * Object#name || ''
    # 
    # e.g. Digest::SHA1.hexdigest "Class:6:Object" #=> 
    #
    # <b>This is a default method appropriate for only the most 
    # basic objects like Class and Module.</b>
    #
    def __gibbler(h=self)
      klass = h.class
      nom = h.name || ''
      
      a = Gibbler.digest '%s:%s:%s' % [klass, nom.size, nom]
      gibbler_debug klass, a, [klass, nom.size, nom]
      a
    end
    
    # A simple override on Object#freeze to create a digest
    # before the object is frozen. Once the object is frozen
    # <tt>obj.gibbler</tt> will return the cached value with
    # out calculation.
    def freeze() self.gibbler; super; self end
    
  end
  
end