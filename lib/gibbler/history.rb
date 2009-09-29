


module Gibbler
  class NoRevert < Gibbler::Error
    def message; "Revert not implemented for #{@obj}" end
  end
  class NoHistory < Gibbler::Error
    def message; "No history for #{@obj}"; end
  end
  class BadDigest < Gibbler::Error
    def message; "Unknown digest: #{@obj}"; end
  end
    
  module History
    extend Attic
    
    attic :__gibbler_history
    
    @@mutex = Mutex.new
    
    def self.mutex; @@mutex; end
    
    # Returns an Array of digests in the order they were committed. 
    # If +short+ is anything but false, the digests will be converted
    # to the short 8 character digests.
    def gibbler_history(short=false)
      # Only a single thread should attempt to initialize the store.
      if self.__gibbler_history.nil?
        @@mutex.synchronize {
          self.__gibbler_history ||= { :history => [], :objects => {}, :stamp => {} }
        }
      end
      if short == false
        self.__gibbler_history[:history]
      else
        self.__gibbler_history[:history].collect { |g| g.short }
      end
    end
    
    # Returns the object stored under the given digest +g+.
    # If +g+ is not a valid digest, returns nil. 
    def gibbler_object(g=nil) 
      g = gibbler_find_long g
      g = self.gibbler_history.last if g.nil?

      return unless gibbler_valid? g
      self.__gibbler_history[:objects][ g ]
    end
    
    # Returns the timestamp (a Time object) when the digest +g+ was committed. 
    # If +g+ is not a valid gibble, returns nil. 
    def gibbler_stamp(g=nil)
      g = gibbler_find_long g
      g = self.gibbler_history.last if g.nil?
      return unless gibbler_valid? g
      self.__gibbler_history[:stamp][ g ]
    end
    
    # Stores a clone of the current object instance using the current
    # digest value. If the object was not changed, this method does
    # nothing but return the gibble. 
    #
    # NOTE: This method is not fully thread safe. It uses a Mutex.synchronize
    # but there's a race condition where two threads can attempt to commit at 
    # near the same time. The first will get the lock and create the commit. 
    # The second will get the lock and create another commit immediately 
    # after. What we probably want is for the second thread to return the 
    # digest for that first snapshot, but how do we know this was a result
    # of the race conditioon rather than two legitimate calls for a snapshot?
    def gibbler_commit
      now, digest, point = nil,nil,nil
      
      if self.__gibbler_history.nil?
        @@mutex.synchronize {
          self.__gibbler_history ||= { :history => [], :objects => {}, :stamp => {} }
        }
      end
      
      @@mutex.synchronize {
        now, digest, point = ::Time.now, self.gibbler, self.clone
        self.__gibbler_history[:history] << digest
        self.__gibbler_history[:stamp][digest] = now
        self.__gibbler_history[:objects][digest] = point
      }
      
      digest
    end
    
    # Revert this object to a previously known state. If called without arguments
    # it will revert to the most recent commit. If a digest is specified +g+, it
    # will revert to that point. 
    #
    # Ruby does not support replacing self (<tt>self = previous_self</tt>) so each 
    # object type needs to implement its own __gibbler_revert! method. This default
    # run some common checks and then defers to self.__gibbler_revert!. 
    # 
    # Raise the following exceptions:
    # * NoRevert: if this object doesn't have a __gibbler_revert! method
    # * NoHistory: This object has no commits
    # * BadDigest: The given digest is not in the history for this object
    #
    # If +g+ matches the current digest value this method does nothing. 
    #
    # Returns the new digest (+g+). 
    def gibbler_revert!(g=nil)
      raise NoRevert unless self.respond_to? :__gibbler_revert!
      raise NoHistory, self.class unless gibbler_history?
      raise BadDigest, g if !g.nil? && !gibbler_valid?(g)
      
      g = self.gibbler_history.last if g.nil?
      g = gibbler_find_long g 
      
      # Do nothing if the given digest matches the current gibble. 
      # NOTE: We use __gibbler b/c it doesn't update self.gibbler_cache.
      unless self.__gibbler == g
        @@mutex.synchronize {
          # Always make sure self.gibbler_digest is a Gibbler::Digest 
          self.gibbler_cache = g.is_a?(Gibbler::Digest) ? g : Gibbler::Digest.new(g)
          self.__gibbler_revert!
        }
      end
      
      self.gibbler_cache
    end
    
    # Is the given digest +g+ contained in the history for this object?
    def gibbler_valid?(g)
      return false unless gibbler_history?
      gibbler_history.member? gibbler_find_long(g)
    end
    
    # Does the current object have any history?
    def gibbler_history?
      !gibbler_history.empty?
    end
    
    # Returns the long digest associated to the short digest +g+.
    # If g is longer than 8 characters it returns the value of +g+.
    def gibbler_find_long(g)
      return if g.nil?
      return g if g.size > 8
      gibbler_history.select { |d| d.match /\A#{g}/ }.first
    end
  end
  
end

class Hash
  include Gibbler::History
  def __gibbler_revert!
    self.clear
    self.merge! self.gibbler_object(self.gibbler_cache)
  end
end

class Array
  include Gibbler::History
  def __gibbler_revert!
    self.clear
    self.push *(self.gibbler_object self.gibbler_cache)
  end
end
  
class String
  include Gibbler::History
  def __gibbler_revert!
    self.clear
    self << (self.gibbler_object self.gibbler_cache)
  end
end
      

