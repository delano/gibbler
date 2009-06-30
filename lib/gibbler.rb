
require 'digest/sha1'

# = Gibbler
# 
# "Hola, Tanneritos"
#
module Gibbler
  VERSION = "0.3.0"
  
  @@gibbler_debug = false
  @@gibbler_digest_type = Digest::SHA1
  
  # Specify a different digest class. The default is +Digest::SHA1+. You 
  # could try +Digest::SHA256+ by doing this: 
  # 
  #     Object.gibbler_digest_type = Digest::SHA256
  #
  def self.gibbler_digest_type=(v)
    @@gibbler_digest_type = v
  end
  # Returns the current debug status (true or false)
  def self.gibbler_debug?;      @@gibbler_debug; end
  # Enable debugging with a true value
  def self.gibbler_debug=(v);   @@gibbler_debug = v; end
  # Returns the current digest class. 
  def self.gibbler_digest_type; @@gibbler_digest_type; end

  # Calculates a digest for the current object instance. 
  # Objects that are a kind of Hash or Array are processed
  # recursively. The length of the returned String depends 
  # on the digest type. 
  def gibble
    #if h.respond_to? :__custom_gibbler
    #  d = h.__custom_gibbler
    #  a = __gibbler '%s:%s:%s' % [klass, d.size, d]
    #  gibbler_debug [klass, a]
    #  a
    #end
    gibbler_debug :GIBBLER, self.class, self
    @__gibble__ = self.__gibbler
  end
  
  def self.digest(str)
    @@gibbler_digest_type.hexdigest str
  end
  
  # Has this object been modified?
  #
  # This method compares the return value from gibble with the 
  # previous value returned by gibble (the value is stored in
  # <tt>@__gibble__</tt>)
  def gibbled?
    was, now = @__gibble__.clone, self.gibble
    gibbler_debug :gibbled?, was, now
    was != now
  end
  
  def gibbler_debug(*args)
    return unless @@gibbler_debug == true
    p args
  end
  def self.gibbler_debug(*args)
    return unless @@gibbler_debug == true
    p args
  end
  
  # Gets the list of instance variables from the standard implementation
  # of the instance_variables method and removes <tt>@__gibble</tt>. 
  def instance_variables
    vars = super
    vars.reject! { |x| x.to_s == '@__gibble__' }
    vars
  end
  
  #def self.included(klass)
  #  # Find the appropriate Gibbler::* module for the inheriting class
  #  gibbler_module = Gibbler.const_get("#{klass}") rescue Gibbler::String
  #  
  #  # If a Gibbler module is not defined, const_get bubbles up
  #  # through the stack to find the constant. This will return 
  #  # the global class (likely itself) so we enforce a default.
  #  gibbler_module = Gibbler::String if gibbler_module == klass
  #  gibbler_debug :constant, klass, gibbler_module
  #  
  #  klass.module_eval do
  #    include gibbler_module
  #  end
  #  
  #end
  
  
  module Complex
    include Gibbler
    def __gibbler
      d = []
      instance_variables.each do |n|
        value = instance_variable_get(n)
        d << '%s:%s:%s' % [value.class, n, value.__gibbler]
      end
      a = d.join(':')
      Gibbler.digest "%s:%d:%s" % [self.class, a.size, a]
    end
  end
  
  module String
    include Gibbler
    def __gibbler(h=self)
      klass = h.class
      value = h.nil? ? "\0" : h.to_s
      a = Gibbler.digest "%s:%d:%s" % [klass, value.size, value]
      gibbler_debug klass, value.size, value, a
      a
    end
  end
      
  module Hash 
    include Gibbler
    def __gibbler(h=self)
      klass = h.class
      d = h.keys.sort { |a,b| a.inspect <=> b.inspect }
      d.collect! do |name| 
        value = h[name]
        '%s:%s:%s' % [value.class, name, value.__gibbler]
      end 
      a = d.join($/).__gibbler 
      gibbler_debug klass, a
      a  
    end
  end
  
  module Array
    include Gibbler
    def __gibbler(h=self)
      klass = h.class
      d, index = [], 0
      h.each do |value| 
        d << '%s:%s:%s' % [value.class, index, value.__gibbler]
        index += 1
      end
      a = d.join($/).__gibbler
      gibbler_debug klass, a
      a
    end
  end
  
end

class Hash
  include Gibbler::Hash
end

class Array
  include Gibbler::Array
end

class String
  include Gibbler::String
end

class Symbol
  include Gibbler::String
end

class Class
  include Gibbler::String
end

class Fixnum
  include Gibbler::String
end





