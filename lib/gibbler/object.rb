

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
    # on the digest type. 
    def gibbler
      gibbler_debug :GIBBLER, self.class, self
      digest = Gibbler::Digest.new self.__gibbler
      self.gibbler_cache = digest unless self.frozen?
      digest
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
  end
  
end