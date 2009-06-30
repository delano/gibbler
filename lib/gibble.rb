
# = Gibble
#
# A tiny subclass of String which adds a
# few digest related convenience methods.
#
class Gibble < String
  
  # Returns the first 8 characters of itself (the digest).
  #
  # e.g. 
  #
  #     "kimmy".gibble         # => c8027100ecc54945ab15ddac529230e38b1ba6a1
  #     "kimmy".gibble.short   # => c8027100
  #
  def short
    self[0..7]
  end
  
end