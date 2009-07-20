

module Gibbler
  
  module Object
    
    def self.included(obj)
      obj.extend Attic
      obj.attic :__gibbler_cache
    end
    
    # Calculates a digest for the current object instance. 
    # Objects that are a kind of Hash or Array are processed
    # recursively. The length of the returned String depends 
    # on the digest type. 
    def gibbler
      gibbler_debug :GIBBLER, self.class, self
      self.__gibbler_cache = Gibbler::Digest.new self.__gibbler
    end

    # Has this object been modified?
    #
    # This method compares the return value from digest with the 
    # previous value returned by gibbler (the value is stored in
    # the attic as <tt>__gibbler_cache</tt>).
    # See Attic[http://github.com/delano/attic]
    def gibbled?
      self.__gibbler_cache ||= self.gibbler
      was, now = self.__gibbler_cache.clone, self.gibbler
      gibbler_debug :gibbled?, was, now
      was != now
    end

    def gibbler_debug(*args)
      return unless Gibbler.debug?
      p args
    end
    
    # Creates a digest for the current state of self based on the 
    # return values for Object#name and Object#class.
    #
    # <b>This is a default method appropriate for only the most 
    # basic objects like Class and Module.</b>
    #
    def __gibbler(h=self)
      klass = h.class
      a = Gibbler.digest '%s:%s:s' % [h.name, klass]
      gibbler_debug klass, a, [h.name, klass]
      a
    end
  end
  
end