
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
    gibbler_debug [:GIBBLER, self.class, self]
    @__gibble__ = self.__gibbler
  end
  
  # Has this object been modified?
  def gibbled?
    was, now = @__gibble__.clone, self.gibble
    gibbler_debug [:gibbled?, was, now]
    was != now
  end
  
  def gibbler_debug(*args)
    return unless @@gibbler_debug == true
    p *args 
  end
end

class Hash
  include Gibbler
  
  def __gibbler(h=self)
    klass = h.class
    d = h.keys.sort { |a,b| a.inspect <=> b.inspect }
    d.collect! do |name| 
      '%s:%s:%s' % [klass, name, h[name].__gibbler]
    end 
    a = d.join($/).__gibbler 
    gibbler_debug [klass, a]
    a  
  end

end

class Array
  extend Gibbler
  
  def __gibbler(h=self)
    klass = h.class
    d, index = [], 0
    h.each do |value| 
      d << '%s:%s:%s' % [h.class, index, value.__gibbler]
      index += 1
    end
    a = d.join($/).__gibbler
    gibbler_debug [klass, a]
    a
  end
  
end

class Object
  include Gibbler
  
  def __gibbler(h=self)
    klass = h.class
    value = h.nil? ? "\0" : h.to_s
    a=@@gibbler_digest_type.hexdigest "%s:%d:%s" % [klass, value.size, value]
    gibbler_debug [klass, value.size, value, a]
    a
  end
end
