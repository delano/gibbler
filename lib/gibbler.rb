
require 'thread'
require 'attic'
require 'digest/sha1'

# = Gibbler
# 
# "Hola, Tanneritos"
#
module Gibbler
  
  VERSION = "0.7.0"
  
  require 'gibbler/digest'
  require 'gibbler/object'
  require 'gibbler/mixins'
  
  class Error < RuntimeError
    def initialize(obj); @obj = obj; end
  end
  
  @@gibbler_debug = false
  @@gibbler_digest_type = ::Digest::SHA1
  
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
  
  # Sends +str+ to Digest::SHA1.hexdigest. If another digest class
  # has been specified, that class will be used instead. 
  # See: digest_type
  def self.digest(str)
    @@gibbler_digest_type.hexdigest str
  end
  
  def self.gibbler_debug(*args)
    return unless Gibbler.debug?
    p args
  end
  
  # Raises an exception. The correct usage is to include a Gibbler::Object:
  # * Gibbler::Complex
  # * Gibbler::String
  # * Gibbler::Object
  # * etc ...
  def self.included(obj)
    raise "You probably want to include Gibbler::Complex or Gibbler::Object"
  end
  
  # Creates a digest based on: 
  # * An Array of instance variable names and values in the format: <tt>CLASS:LENGTH:VALUE</tt>
  #   * The gibbler method is called on each element so if it is a Hash or Array etc it 
  #     will be parsed recursively according to the gibbler method for that class type.
  # * Digest the Array of digests  
  # * Return the digest for <tt>class:length:value</tt> where:
  #   * "class" is equal to the current object class (e.g. FullHouse).
  #   * "length" is the size of the Array of digests (which should equal
  #     the number of instance variables in the object).
  #   * "value" is the Array of digests joined with a colon (":").
  #
  # This method can be used by any class which stores values in instance variables. 
  #
  #     class Episodes
  #       include Gibbler::Complex
  #       attr_accessor :season, :year, :cast
  #     end
  #
  module Complex
    include Gibbler::Object
    
    def self.included(obj)
      obj.extend Attic
      obj.attic :gibbler_cache
    end
    
    # Creates a digest for the current state of self. 
    def __gibbler(h=self)
      klass = h.class
      d = []
      gibbler_debug :ivars, instance_variables
      instance_variables.sort.each do |n|
        value = instance_variable_get(n)
        d << '%s:%s:%s' % [value.class, n, value.__gibbler]
      end
      d = d.join(':').__gibbler
      a = Gibbler.digest "%s:%d:%s" % [klass, d.size, d]
      gibbler_debug klass, a, [klass, d.size, d]
      a
    end
    
    def __gibbler_revert!
      state = self.gibbler_object self.gibbler_cache
      state.instance_variables do |n|
        v = state.instance_variable_get n
        self.instance_variable_set v
      end
    end
    
  end
  
  # Creates a digest based on: <tt>CLASS:LENGTH:VALUE</tt>. 
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
  #     class MyStringLikeClass 
  #       include Gibbler::String
  #     end
  #
  module String
    include Gibbler::Object
    
    def self.included(obj)
      obj.extend Attic
      obj.attic :gibbler_cache
    end
    
    # Creates a digest for the current state of self. 
    def __gibbler(h=self)
      klass = h.class
      value = h.nil? ? "\0" : h.to_s
      a = Gibbler.digest "%s:%d:%s" % [klass, value.size, value]
      gibbler_debug klass, a, [klass, value.size, value]
      a
    end
  end
  
  # Creates a digest based on: 
  # * parse each key, value pair into an Array containing keys: <tt>CLASS:KEY:VALUE.__gibbler</tt>
  #   * The gibbler method is called on each element so if it is a Hash or Array etc it 
  #     will be parsed recursively according to the gibbler method for that class type.
  # * Digest the Array of digests  
  # * Return the digest for <tt>class:length:value</tt> where:
  #   * "class" is equal to the current object class (e.g. Hash).
  #   * "length" is the size of the Array of digests (which should equal
  #     the number of keys in the original Hash object).
  #   * "value" is the Array of digests joined with a colon (":").
  #
  # This method can be used by any class with a <tt>keys</tt> method. 
  #
  #     class MyOrderedHash
  #       include Gibbler::Hash
  #     end
  #
  module Hash 
    include Gibbler::Object
    
    def self.included(obj)
      obj.extend Attic
      obj.attic :gibbler_cache
    end
    
    # Creates a digest for the current state of self. 
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
  
  # Creates a digest based on:
  # * parse each element into an Array of digests like: <tt>CLASS:INDEX:VALUE.__gibbler</tt>
  #   * The gibbler method is called on each element so if it is a Hash or Array etc it 
  #     will be parsed recursively according to the gibbler method for that class type. 
  # * Digest the Array of digests 
  # * Return the digest for <tt>class:length:value</tt> where:
  #   * "class" is equal to the current object class (e.g. Array).
  #   * "length" is the size of the Array of digests (which should equal
  #     the number of elements in the original Array object).
  #   * "value" is the Array of digests joined with a colon (":").
  #
  # This method can be used by any class with an <tt>each</tt> method.
  #
  #     class MyNamedArray 
  #       include Gibbler::Array
  #     end
  #
  module Array
    include Gibbler::Object
    
    def self.included(obj)
      obj.extend Attic
      obj.attic :gibbler_cache
    end
    
    # Creates a digest for the current state of self. 
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
  
  # Creates a digest based on: <tt>CLASS:LENGTH:TIME</tt>. 
  # Times are calculated based on the equivalent time in UTC. 
  # e.g.
  # 
  #     Time.parse('2009-08-25 16:43:53 UTC')     => 73b4635f
  #     Time.parse('2009-08-25 12:43:53 -04:00')  => 73b4635f
  #
  # To use use method in other classes simply:
  #
  #     class ClassLikeTime 
  #       include Gibbler::Time
  #     end
  #
  module Time
    include Gibbler::Object
    
    def self.included(obj)
      obj.extend Attic
      obj.attic :gibbler_cache
    end
    
    # Creates a digest for the current state of self. 
    def __gibbler(h=self)
      klass = h.class
      value = h.nil? ? "\0" : h.utc.strftime('%Y-%m-%d %H:%M:%S UTC')
      a = Gibbler.digest "%s:%d:%s" % [klass, value.size, value]
      gibbler_debug klass, a, [klass, value.size, value]
      a
    end
  end
  
  # Creates a digest based on: <tt>CLASS:LENGTH:DATETIME</tt>. 
  # Dates are calculated based on the equivalent datetime in UTC. 
  # e.g.
  # 
  #     DateTime.parse('2009-08-25T17:00:40+00:00')  => ad64c769
  #     DateTime.parse('2009-08-25T13:00:40-04:00')  => ad64c769
  #
  # To use use method in other classes simply:
  #
  #     class ClassLikeTime 
  #       include Gibbler::Time
  #     end
  #
  module DateTime
    include Gibbler::Object
    
    def self.included(obj)
      obj.extend Attic
      obj.attic :gibbler_cache
    end
    
    # Creates a digest for the current state of self. 
    def __gibbler(h=self)
      klass = h.class
      value = h.nil? ? "\0" : h.new_offset(0).to_s
      a = Gibbler.digest "%s:%d:%s" % [klass, value.size, value]
      gibbler_debug klass, a, [klass, value.size, value]
      a
    end
    
  end
  
  # Creates a digest based on: <tt>CLASS:LENGTH:VALUE</tt>
  # where LENGTH is the number of elements in the range
  # and VALUE is the string representation of the range. 
  # e.g.
  #     
  #     (1..100)   =>  Range:100:1..100  =>  d73ae2a7
  #     (1...100)  =>  Range:99:1...100  =>  46c8a7d0
  #
  # To use use method in other classes simply:
  #
  #     class ClassLikeRange 
  #       include Gibbler::Range
  #     end
  #
  module Range
    include Gibbler::Object
    
    def self.included(obj)
      obj.extend Attic
      obj.attic :gibbler_cache
    end
    
    # Creates a digest for the current state of self. 
    def __gibbler(h=self)
      klass = h.class
      value = h.nil? ? "\0" : h.to_s
      size = h.nil? ? 0 : h.to_a.size
      a = Gibbler.digest "%s:%d:%s" % [klass, size, value]
      gibbler_debug klass, a, [klass, size, value]
      a
    end
    
  end
  
  # Creates a digest based on: <tt>CLASS:\0</tt>
  #
  # e.g.
  #
  #     nil.gibbler      # => 06fdf26b
  #
  module Nil
    include Gibbler::Object

    def self.included(obj)
      obj.extend Attic
      obj.attic :gibbler_cache
    end

    # Creates a digest for the current state of self. 
    def __gibbler(h=self)
      klass = h.class
      a = Gibbler.digest "%s:%s" % [klass, "\0"]
      gibbler_debug klass, a, [klass, "\0"]
      a
    end
  end
  
  # Creates a digest based on: <tt>CLASS:PATHLENGTH:PATH</tt>
  # where PATHLENGTH is the length of the PATH string. PATH is
  # not modified in any way (it is not converted to an absolute
  # path). 
  # 
  # NOTE: You may expect this method to include other information
  # like the file contents and modified date (etc...). The reason
  # we do not is because Gibbler is concerned only about Ruby and
  # not the outside world. There are many complexities in parsing
  # file data and attributes which would make it difficult to run
  # across platforms and Ruby versions / engines. If you want to 
  #
  # e.g.
  #    
  #    File.new('.')        # => c8bc8b3a
  #    File.new('/tmp')     # => 3af85a19
  #    File.new('/tmp/')    # => 92cbcb7d
  #   
  module File
    include Gibbler::Object
    
    def self.included(obj)
      obj.extend Attic
      obj.attic :gibbler_cache
    end
    
    # Creates a digest for the current state of self. 
    def __gibbler(h=self)
      klass = h.class
      value = h.nil? ? "\0" : h.path
      a = Gibbler.digest "%s:%d:%s" % [klass, value.size, value]
      gibbler_debug klass, a, [klass, value.size, value]
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

class NilClass;            include Gibbler::Nil;       end
class Class;               include Gibbler::Object;    end
class Module;              include Gibbler::Object;    end
class Proc;                include Gibbler::Object;    end
class String;              include Gibbler::String;    end
class Regexp;              include Gibbler::String;    end
class Fixnum;              include Gibbler::String;    end
class Bignum;              include Gibbler::String;    end
class TrueClass;           include Gibbler::String;    end
class FalseClass;          include Gibbler::String;    end
class Float;               include Gibbler::String;    end
class Symbol;              include Gibbler::String;    end
class Date;                include Gibbler::String;    end
class Hash;                include Gibbler::Hash;      end
class Array;               include Gibbler::Array;     end
class Time;                include Gibbler::Time;      end
class DateTime < Date;     include Gibbler::DateTime;  end
class Range;               include Gibbler::Range;     end
class File;                include Gibbler::File;      end
class TempFile;            include Gibbler::File;      end

# URI::Generic must be included towards the 
# end b/c it runs Object#freeze statically.
module URI; class Generic; include Gibbler::String;    end; end





