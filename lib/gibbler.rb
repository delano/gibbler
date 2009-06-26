
require 'digest/sha1'

# = Object
# 
# "Hola, Tanneritos"
#
class Object
  
  @@gibbler_digest_type = Digest::SHA1
  @@gibbler_debug = false
  
  # Specify a different digest class. The default is +Digest::SHA1+. You 
  # could try +Digest::SHA256+ by doing this: 
  # 
  #     Object.gibbler_digest_type = Digest::SHA256
  #
  def self.gibbler_digest_type=(v)
    @@gibbler_digest_type = v
  end
  
    # Returns the current digest class. 
  def self.gibbler_digest_type; @@gibbler_digest_type; end
    # Returns the current debug status (true or false)
  def self.gibbler_debug?;      @@gibbler_debug; end
    # Enable debugging with a true value
  def self.gibbler_debug=(v);   @@gibbler_debug = v; end
  
  # Calculates a digest for the current object instance. 
  # Objects that are a kind of Hash or Array are processed
  # recursively. The length of the returned String depends 
  # on the digest type. 
  def to_gibble
    gibbler_debug [:GIBBLER, self.class, self]
    @__gibble__ = __default_gibbler self
  end
  
  # Has this object been modified?
  def gibbled?
    was, now = @__gibble__.clone, self.to_gibble
    gibbler_debug [:gibbled?, was, now]
    was != now
  end
  
  private
  def __default_gibbler(h)
    klass = h.class
    if h.respond_to? :__custom_gibbler
      h.__custom_gibbler
      
    elsif h.kind_of?(Hash) || h.respond_to?(:keys)
      d = h.keys.sort { |a,b| a.inspect <=> b.inspect }
      d.collect! do |name| 
        '%s:%s:%s' % [klass, name, __default_gibbler(h[name])]
      end 
      a = __default_gibbler d.join($/)
      gibbler_debug [klass, a]
      a
      
    elsif h.kind_of?(Array)
      d, index = [], 0
      h.each do |value| 
        d << '%s:%s:%s' % [h.class, index, __default_gibbler(value)]
        index += 1
      end
      a = __default_gibbler d.join($/)
      gibbler_debug [klass, a]
      a
      
    else
      value = h.nil? ? "\0" : h.to_s
      a=@@gibbler_digest_type.hexdigest "%s:%d:%s" % [klass, value.size, value]
      gibbler_debug [klass, value.size, value, a]
      a
      
    end
  end
  
  def gibbler_debug(*args)
    return unless @@gibbler_debug == true
    p *args 
  end
end