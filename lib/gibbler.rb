
require 'digest/sha1'

# = Gibbler
# 
# "Hola, Tanneritos"
#
module Gibbler
  VERSION = "0.4.0"
  
  require 'gibbler/history'
  require 'gibble'
  
  @@gibbler_debug = false
  @@gibbler_digest_type = Digest::SHA1
  
  # Specify a different digest class. The default is +Digest::SHA1+. You 
  # could try +Digest::SHA256+ by doing this: 
  # 
  #     Object.gibbler_digest_type = Digest::SHA256
  #
  def self.digest_type=(v)
    @@gibbler_digest_type = v
  end
  # Returns the current debug status (true or false)
  def self.debug?;      @@gibbler_debug; end
  def self.enable_debug;  @@gibbler_debug = true; end
  def self.disable_debug;  @@gibbler_debug = false; end
  # Returns the current digest class. 
  def self.digest_type; @@gibbler_digest_type; end

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
    @__gibble__ = Gibble.new self.__gibbler
    @__gibble__
  end
  
  # Sends +str+ to Digest::SHA1.hexdigest. If another digest class
  # has been specified, that class will be used instead. 
  # See: digest_type
  def self.digest(str)
    @@gibbler_digest_type.hexdigest str
  end
  
  # Has this object been modified?
  #
  # This method compares the return value from gibble with the 
  # previous value returned by gibble (the value is stored in
  # <tt>@__gibble__</tt>)
  def gibbled?
    @__gibble__ ||= self.gibble
    was, now = @__gibble__.clone, self.gibble
    gibbler_debug :gibbled?, was, now
    was != now
  end
  
  def gibbler_debug(*args)
    return unless Gibbler.debug?
    p args
  end
  def self.gibbler_debug(*args)
    return unless Gibbler.debug?
    p args
  end
  
  # Gets the list of instance variables from the standard implementation
  # of the instance_variables method and removes <tt>@__gibble__</tt>. 
  # Any class the includes Gibbler or Gibbler::* will use this version of
  # instance_variables. It's important because we don't want the current
  # gibble value to affect the next gibble. 
  def instance_variables
    vars = super
    vars.reject! { |e| e.to_s =~ /^@__gibble/ }
    vars
  end

  module Complex
    include Gibbler
    # Creates a gibble based on: 
    # * An Array of instance variable names and values in the format: <tt>CLASS:LENGTH:VALUE</tt>
    #   * The gibble method is called on each element so if it is a Hash or Array etc it 
    #     will be parsed recursively according to the gibbler method for that class type.
    # * Gibble the Array of gibbles 
    # * Return the digest for <tt>class:length:value</tt> where:
    #   * "class" is equal to the current object class (e.g. FullHouse).
    #   * "length" is the size of the Array of gibbles (which should equal
    #     the number of instance variables in the object).
    #   * "value" is the Array of gibbles joined with a colon (":").
    #
    # This method can be used by any class which stores values in instance variables. 
    #
    def __gibbler(h=self)
      klass = h.class
      d = []
      instance_variables.each do |n|
        value = instance_variable_get(n)
        d << '%s:%s:%s' % [value.class, n, value.__gibbler]
      end
      d = d.join(':').__gibbler
      a = Gibbler.digest "%s:%d:%s" % [klass, d.size, d]
      gibbler_debug klass, a, [klass, d.size, d]
      a
    end
  end
  
  module String
    include Gibbler
    # Creates a gibble based on: <tt>CLASS:LENGTH:VALUE</tt>. 
    # This method can be used for any class where the <tt>to_s</tt>
    # method returns an appropriate unique value for this instance. 
    # It's used by default for Symbol, Class, Fixnum, and Bignum.
    # e.g.
    # 
    #     "str" => String:3:str => 509a839ca1744c72e37759e7684ff0daa3b61427
    #     :sym  => Symbol:3:sym => f3b7b3ca9529002c6826b1ef609d3583c356c8c8
    #
    # To use use method in other classes simply:
    #
    #     class MyClass
    #       include Gibbler::String
    #     end
    #
    def __gibbler(h=self)
      klass = h.class
      value = h.nil? ? "\0" : h.to_s
      a = Gibbler.digest "%s:%d:%s" % [klass, value.size, value]
      gibbler_debug klass, a, [klass, value.size, value]
      a
    end
  end
      
  module Hash 
    include Gibbler
    
    # Creates a gibble based on: 
    # * parse each key, value pair into an Array containing keys: <tt>CLASS:KEY:VALUE.__gibbler</tt>
    #   * The gibble method is called on each element so if it is a Hash or Array etc it 
    #     will be parsed recursively according to the gibbler method for that class type.
    # * Gibble the Array of gibbles 
    # * Return the digest for <tt>class:length:value</tt> where:
    #   * "class" is equal to the current object class (e.g. Hash).
    #   * "length" is the size of the Array of gibbles (which should equal
    #     the number of keys in the original Hash object).
    #   * "value" is the Array of gibbles joined with a colon (":").
    #
    # This method can be used by any class with a <tt>keys</tt> method. 
    #
    # e.g. 
    #
    #     class OrderedHash
    #       include Gibbler::Hash
    #     end
    #
    def __gibbler(h=self)
      klass = h.class
      d = h.keys.sort { |a,b| a.inspect <=> b.inspect }
      d.collect! do |name| 
        value = h[name]
        '%s:%s:%s' % [value.class, name, value.__gibbler]
      end 
      d = d.join(':').__gibbler
      a = Gibbler.digest '%s:%s:%s' % [klass, d.size, d]
      gibbler_debug klass, a, [klass, d.size, d]
      a  
    end
  end
  
  module Array
    include Gibbler
    
    # Creates a gibble based on:
    # * parse each element into an Array of gibbles like: <tt>CLASS:INDEX:VALUE.__gibbler</tt>
    #   * The gibble method is called on each element so if it is a Hash or Array etc it 
    #     will be parsed recursively according to the gibbler method for that class type. 
    # * Gibble the Array of gibbles
    # * Return the digest for <tt>class:length:value</tt> where:
    #   * "class" is equal to the current object class (e.g. Array).
    #   * "length" is the size of the Array of gibbles (which should equal
    #     the number of elements in the original Array object).
    #   * "value" is the Array of gibbles joined with a colon (":").
    #
    # This method can be used by any class with an <tt>each</tt> method.
    #
    # e.g.
    #
    #     class NamedArray 
    #       include Gibbler::Array
    #     end
    #
    def __gibbler(h=self)
      klass = h.class
      d, index = [], 0
      h.each do |value| 
        d << '%s:%s:%s' % [value.class, index, value.__gibbler]
        index += 1
      end
      d = d.join(':').__gibbler
      a = Gibbler.digest '%s:%s:%s' % [klass, d.size, d]
      gibbler_debug klass, a, [klass, d.size, d]
      a
    end
  end
  
  
  ##--
  ## NOTE: this was used when Gibbler supported "include Gibbler". We
  ## now recommend the "include Gibbler::String" approach. This was an 
  ## interesting approach so I'm keeping the code here for reference. 
  ##def self.included(klass)
  ##  # Find the appropriate Gibbler::* module for the inheriting class
  ##  gibbler_module = Gibbler.const_get("#{klass}") rescue Gibbler::String
  ##  
  ##  # If a Gibbler module is not defined, const_get bubbles up
  ##  # through the stack to find the constant. This will return 
  ##  # the global class (likely itself) so we enforce a default.
  ##  gibbler_module = Gibbler::String if gibbler_module == klass
  ##  gibbler_debug :constant, klass, gibbler_module
  ##  
  ##  klass.module_eval do
  ##    include gibbler_module
  ##  end
  ##  
  ##end
  ##++
  
  
end

class Hash
  include Gibbler::Hash
  
  def gibble_revert
    raise "No history (#{self.class})" if @__gibbles__.nil? || @__gibbles__.empty?
    @@mutex.synchronize {
      self.clear
      @__gibble__ = @__gibbles__[:order].last
      self.merge! @__gibbles__[:objects][ @__gibble__ ]
    }
    @__gibble__
  end
  
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

class Bignum
  include Gibbler::String
end

class TrueClass
  include Gibbler::String
end

class FalseClass
  include Gibbler::String
end

class Float
  include Gibbler::String
end




