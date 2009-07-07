

module Gibbler
  
  module Object
    
    # Gets the list of instance variables from the standard implementation
    # of the instance_variables method and removes all that 
    # begin with <tt>@__gibbler</tt>. 
    # Any class the includes Gibbler or Gibbler::* will use this version of
    # instance_variables. It's important because we don't want the current
    # digest value to affect the next gibble.
    # 
    # This is also critical for objects that include Gibbler::Complex b/c
    # it deals explicitly with instance variables. If it sees the __gibbler
    # variables it will go bananas. 
    #
    def instance_variables
      vars = super
      vars.reject! { |e| e.to_s =~ /^@__gibble/ }
      vars
    end
    
    
    # Calculates a digest for the current object instance. 
    # Objects that are a kind of Hash or Array are processed
    # recursively. The length of the returned String depends 
    # on the digest type. 
    def gibbler
      #if h.respond_to? :__custom_gibbler
      #  d = h.__custom_gibbler
      #  a = __gibbler '%s:%s:%s' % [klass, d.size, d]
      #  gibbler_debug [klass, a]
      #  a
      #end
      gibbler_debug :GIBBLER, self.class, self
      @__gibbler_digest__ = Gibbler::Digest.new self.__gibbler
      @__gibbler_digest__
    end

    
    # Has this object been modified?
    #
    # This method compares the return value from digest with the 
    # previous value returned by gibbler (the value is stored in
    # <tt>@__gibbler_digest__</tt>)
    def gibbled?
      @__gibbler_digest__ ||= self.gibbler
      was, now = @__gibbler_digest__.clone, self.gibbler
      gibbler_debug :gibbled?, was, now
      was != now
    end

    def gibbler_debug(*args)
      return unless Gibbler.debug?
      p args
    end
    
  end
  
end