
require 'digest/sha1'

class Object
  
  @@gibbler_digest_type = Digest::SHA1
  @@gibbler_debug = true
  
  def self.gibbler_digest_type=(v)
    @@gibbler_digest_type = v
  end
  def self.gibbler_digest_type; @@gibbler_digest_type; end
  
  
  def gibbler(h=self)
    gibbler_debug [:GIBBLER, h.class, h]
    @__gibbler__ = __generate_gibbler h
  end
  
  def gibbled?
    was = @__gibbler__.clone
    ret = was != self.gibbler
    gibbler_debug [:gibbled?, was, @__gibbler__]
    ret
  end
  
  private
  def __generate_gibbler(h)
    klass = h.class
    if h.kind_of?(Hash) || h.respond_to?(:keys)
      d = h.keys.sort { |a,b| a.inspect <=> b.inspect }
      d.collect! { |name| '%s:%s:%s' % [klass, name, __generate_gibbler(h[name])] }
      a=__generate_gibbler d.join($/)
      gibbler_debug [klass, a]
      a
    elsif h.kind_of?(Array)
      d, index = [], 0
      h.each do |value| 
        d << '%s:%s:%s' % [h.class, index, __generate_gibbler(value)]
        index += 1
      end
      a=__generate_gibbler d.join($/)
      gibbler_debug [klass, a]
      a
    elsif h.respond_to? :gibble
     
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