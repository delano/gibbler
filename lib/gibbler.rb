
require 'digest/sha1'

class Object
  
  DIGEST_TYPE = Digest::SHA1
  
  def gibbler(h=self)
    @__ghash__ = __generate_gibbler h
  end
  
  def changed?
    @__ghash__ != self.gibbler
  end
  
  private
  def __generate_gibbler(h)
    if h.kind_of? Hash
      d = h.keys.sort { |a,b| a.inspect <=> b.inspect }
      d.collect! { |name| '%s:%s:%s' % [h.class, name, __generate_gibbler(h[name])] }
      __generate_gibbler d.join($/)
    elsif h.kind_of? Array
      d = []
      h.each_with_index do |value,index| 
        '%s:%s:%s' % [h.class, index, __generate_gibbler(value)]
      end
      __generate_gibbler d.join($/)
    else
      DIGEST_TYPE.hexdigest Hash.gibblerstr(h)
    end
  end
  
  def self.gibblerstr(obj)
    klass = obj.class
    value = obj.nil? ? "\0" : obj.inspect
    "%s:%d:%s" % [klass, value.size, value]
  end
  
end