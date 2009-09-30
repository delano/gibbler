
# = Gibbler::Digest
#
# A tiny subclass of String which adds a
# few digest related convenience methods.
#
class Gibbler::Digest < String
  
  # Returns the first 8 characters of itself (the digest).
  #
  # e.g. 
  #
  #     "kimmy".gibbler         # => c8027100ecc54945ab15ddac529230e38b1ba6a1
  #     "kimmy".gibbler.short   # => c8027100
  #
  def short
    self[0..7]
  end
  
  # Returns the first 6 characters of itself (the digest).
  #
  # e.g. 
  #
  #     "kimmy".gibbler         # => c8027100ecc54945ab15ddac529230e38b1ba6a1
  #     "kimmy".gibbler.tiny    # => c80271
  #
  def shorter
    self[0..5]
  end
  
  # Returns the first 4 characters of itself (the digest).
  #
  # e.g. 
  #
  #     "kimmy".gibbler         # => c8027100ecc54945ab15ddac529230e38b1ba6a1
  #     "kimmy".gibbler.tiny    # => c802
  #
  def tiny
    self[0..3]
  end
  
  def ==(g)
    return true if self.to_s == g.to_s
    return true if self.short.to_s == g.to_s
    false
  end
  
end