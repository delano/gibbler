unless defined?(GIBBLER_LIB_HOME)
  GIBBLER_LIB_HOME = File.expand_path File.dirname(__FILE__) 
end

%w{attic}.each do |dir|
  $:.unshift File.join(GIBBLER_LIB_HOME, '..', '..', dir, 'lib')
end

require 'thread'
require 'attic'
require 'digest/sha1'

# = Gibbler
# 
# "Hola, Tanneritos"
#
module Gibbler
  module VERSION
    def self.to_s
      load_config
      [@version[:MAJOR], @version[:MINOR], @version[:PATCH]].join('.')
    end
    alias_method :inspect, :to_s
    def self.load_config
      require 'yaml'
      @version ||= YAML.load_file(::File.join(GIBBLER_LIB_HOME, '..', 'VERSION.yml'))
    end
  end
  
  @default_base = 16
  @secret = nil
  class << self
    attr_accessor :secret, :default_base
  end
  
  require 'gibbler/mixins'
  
  class Error < RuntimeError
    def initialize(obj); @obj = obj; end
  end
end

# = Gibbler::Digest
#
# A tiny subclass of String which adds a
# few digest related convenience methods.
#
class Gibbler::Digest < String
  
  # Return an integer assuming base is Gibbler.default_base. 
  def to_i(base=nil)
    base ||= Gibbler.default_base
    super(base)
  end
  
  # Returns a string. Takes an optional base. 
  def to_s(base=nil)
    base.nil? ? super() : super().to_i(Gibbler.default_base).to_s(base)
  end
  
  def base(base=Gibbler.default_base)
    self.class.new(self.to_i(Gibbler.default_base).to_s(base))
  end
  
  def base36
    base(36)
  end
  
  # Shorten the digest to the given (optional) length. 
  def shorten(len=20)
    self[0..len-1]
  end
  
  # Returns the first 8 characters of itself (the digest).
  #
  # e.g. 
  #
  #     "kimmy".gibbler         # => c8027100ecc54945ab15ddac529230e38b1ba6a1
  #     "kimmy".gibbler.short   # => c8027100
  #
  def short
    shorten(8)
  end
  
  # Returns the first 6 characters of itself (the digest).
  #
  # e.g. 
  #
  #     "kimmy".gibbler         # => c8027100ecc54945ab15ddac529230e38b1ba6a1
  #     "kimmy".gibbler.shorter # => c80271
  #
  def shorter
    shorten(6)
  end
  
  # Returns the first 4 characters of itself (the digest).
  #
  # e.g. 
  #
  #     "kimmy".gibbler         # => c8027100ecc54945ab15ddac529230e38b1ba6a1
  #     "kimmy".gibbler.tiny    # => c802
  #
  def tiny
    shorten(4)
  end
  
  # Returns true when +ali+ matches +self+
  #
  #    "kimmy".gibbler == "c8027100ecc54945ab15ddac529230e38b1ba6a1"  # => true
  #    "kimmy".gibbler == "c8027100"                                  # => false
  #
  def ==(ali)
    return true if self.to_s == ali.to_s
    false
  end
  
  # Returns true when +g+ matches one of: +self+, +short+, +shorter+, +tiny+
  #
  #    "kimmy".gibbler === "c8027100ecc54945ab15ddac529230e38b1ba6a1" # => true
  #    "kimmy".gibbler === "c8027100"                                 # => true
  #    "kimmy".gibbler === "c80271"                                   # => true
  #    "kimmy".gibbler === "c802"                                     # => true
  #
  def ===(g)
    return true if [to_s, short, shorter, tiny].member?(g.to_s)
    false
  end
end

module Gibbler
  module Object
    
    def self.included(obj)
      obj.extend Attic
      obj.attic :gibbler_cache
      # Backwards compatibility for <= 0.6.2 
      obj.send :alias_method, :__gibbler_cache, :gibbler_cache
    end
    
    def self.gibbler_fields
    end
    def gibbler_fields
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
    def gibbler(digest_type=nil)
      #gibbler_debug caller[0]
      gibbler_debug :GIBBLER, self.class, self
      return self.gibbler_cache if self.frozen?
      self.gibbler_cache = Gibbler::Digest.new self.__gibbler(digest_type)
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
    # * Length of Object#name || 0
    # * Object#name || ''
    # 
    # e.g. Digest::SHA1.hexdigest "Class:6:Object" #=> 
    #
    # <b>This is a default method appropriate for only the most 
    # basic objects like Class and Module.</b>
    #
    def __gibbler(digest_type=nil)
      klass = self.class
      nom = self.name if self.respond_to?(:name)
      nom ||= ''
      a = Gibbler.digest '%s:%s:%s' % [klass, nom.size, nom], digest_type
      gibbler_debug klass, a, [klass, nom.size, nom]
      a
    end
    
    # A simple override on Object#freeze to create a digest
    # before the object is frozen. Once the object is frozen
    # <tt>obj.gibbler</tt> will return the cached value with
    # out calculation.
    def freeze()
      gibbler_debug :FREEZE, self.class, caller[0] if Gibbler.debug?
      self.gibbler
      super
      self
    end
    
  end
  
end


module Gibbler

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
  def self.debug=(v);  @@gibbler_debug = v; end
  # Returns the current digest class. 
  def self.digest_type; @@gibbler_digest_type; end
  
  # Sends +str+ to Digest::SHA1.hexdigest. If another digest class
  # has been specified, that class will be used instead. 
  # If Gibbler.secret is set, +str+ will be prepended with the
  # value. 
  #
  # See: digest_type
  def self.digest(str, digest_type=nil)
    digest_type ||= @@gibbler_digest_type
    str = [Gibbler.secret, str].join(':') unless Gibbler.secret.nil?
    dig = digest_type.hexdigest(str)
    dig = dig.to_i(16).to_s(Gibbler.default_base) if 16 != Gibbler.default_base
    dig
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
      obj.class_eval do
        @__gibbler_fields = []
        def self.gibbler_fields
          @__gibbler_fields
        end
        def self.gibbler *fields
          @__gibbler_fields.push *fields
        end
        def self.inherited(obj)
          obj.extend Attic
          obj.attic :gibbler_cache
          fields = @__gibbler_fields.clone
          obj.class_eval do
            @__gibbler_fields = fields
          end
        end
      end
    end
    
    def gibbler_fields
      f = [self.class.gibbler_fields].compact.flatten
      if f.empty?
        f = instance_variables.sort.collect { |n|
          n.to_s[1..-1].to_sym # remove the '@'
        }
      end
      f
    end
    
    # Creates a digest for the current state of self. 
    def __gibbler(digest_type=nil)
      klass = self.class
      d = []
      gibbler_debug :gibbler_fields, gibbler_fields
      gibbler_fields.each do |n|
        value = instance_variable_get("@#{n}")
        unless value.respond_to? :__gibbler
          gibbler_debug klass, :skipping, n
          next
        end
        d << '%s:%s:%s' % [value.class, n, value.__gibbler(digest_type)]
      end
      d = d.join(':').__gibbler(digest_type)
      a = Gibbler.digest "%s:%d:%s" % [klass, d.size, d], digest_type
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
    def __gibbler(digest_type=nil)
      klass = self.class
      value = self.nil? ? "\0" : self.to_s
      a = Gibbler.digest "%s:%d:%s" % [klass, value.size, value], digest_type
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
    def __gibbler(digest_type=nil)
      klass = self.class
      d = self.keys.sort { |a,b| a.inspect <=> b.inspect }
      d.collect! do |name| 
        value = self[name]
        '%s:%s:%s' % [value.class, name, value.__gibbler(digest_type)]
      end 
      d = d.join(':').__gibbler(digest_type)
      a = Gibbler.digest '%s:%s:%s' % [klass, d.size, d], digest_type
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
    def __gibbler(digest_type=nil)
      klass = self.class
      d, index = [], 0
      self.each do |value| 
        d << '%s:%s:%s' % [value.class, index, value.__gibbler(digest_type)]
        index += 1
      end
      d = d.join(':').__gibbler(digest_type)
      a = Gibbler.digest '%s:%s:%s' % [klass, d.size, d], digest_type
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
    def __gibbler(digest_type=nil)
      klass = self.class
      value = self.nil? ? "\0" : self.utc.strftime('%Y-%m-%d %H:%M:%S UTC')
      a = Gibbler.digest "%s:%d:%s" % [klass, value.size, value], digest_type
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
    def __gibbler(digest_type=nil)
      klass = self.class
      value = self.nil? ? "\0" : self.new_offset(0).to_s
      a = Gibbler.digest "%s:%d:%s" % [klass, value.size, value], digest_type
      gibbler_debug klass, a, [klass, value.size, value]
      a
    end
    
  end
  
  # Creates a digest based on: <tt>CLASS:EXCLUDE?:FIRST:LAST</tt>
  # where EXCLUDE? is a boolean value whether the Range excludes
  # the last value (i.e. 1...100) and FIRST and LAST are the values
  # returned by Range#first and Range#last.
  # e.g.
  #     
  #     (1..100)   =>  Range:false:1:100  =>  54506352
  #     (1...100)  =>  Range:true:1:100   =>  f0cad8cc
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
    def __gibbler(digest_type=nil)
      klass = self.class
      if self.nil? 
        first, last, exclude = "\0", "\0", "\0"
      else
        first, last, exclude = self.first, self.last, self.exclude_end?
      end
      a = Gibbler.digest "%s:%s:%s:%s" % [klass, exclude, first, last], digest_type
      gibbler_debug klass, a, [klass, exclude, first, last]
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
    def __gibbler(digest_type=nil)
      klass = self.class
      a = Gibbler.digest "%s:%s" % [klass, "\0"], digest_type
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
    def __gibbler(digest_type=nil)
      klass = self.class
      value = self.nil? ? "\0" : self.path
      a = Gibbler.digest "%s:%d:%s" % [klass, value.size, value], digest_type
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

# Bundler calls freeze on an instance of Gem::Platform
module Gem; class Platform; include Gibbler::Complex;  end; end



