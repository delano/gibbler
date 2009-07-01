


module Gibbler
  class NoRevert < RuntimeError
    def initialize(obj); @obj = obj; end
    def message; "Revert not implemented for #{@obj}" end
  end
  
  module History
    
    @@mutex = Mutex.new
    
    def gibble_history
      @@mutex.synchronize {
        @__gibbles__ ||= { :order => [], :objects => {}, :stamp => {} }
      }
      
      @__gibbles__[:order]
    end
    
    # Stores a clone of the current object instance using the current
    # gibble value. If the object was not changed, this method does
    # nothing but return the gibble. 
    #
    # NOTE: This method is not fully thread safe. It uses a Mutex.synchronize
    # but there's a race condition where two threads attempt a snapshot at 
    # near the same time. The first will get the lock and create the snapshot. 
    # The second will get the lock and create another snapshot immediately 
    # after. What we probably want is for the second thread to return the 
    # gibble for that first snapshot, but how do we know this was a result
    # of the race conditioon rather than two legitimate calls for a snapshot?
    def gibble_snapshot
      now, gibble, point = nil,nil,nil
      @@mutex.synchronize {
        @__gibbles__ ||= { :order => [], :objects => {}, :stamp => {} }
        now, gibble, point = Time.now, self.gibble, self.clone
        @__gibbles__[:order] << gibble
        @__gibbles__[:stamp][now.to_i] = gibble
        @__gibbles__[:objects][gibble] = point
      }
      gibble
    end
    
    # Ruby does not support replacing self (<tt>self = previous_self</tt>) so each 
    # object type needs to implement its own gibble_revert method. This default
    # raises a Gibbler::NoRevert exception. 
    def gibble_revert
      raise NoRevert, self.class
    end
    
  end
  
end

class Gibbler::Hash
  def gibble_revert
    raise "No history (#{self.class})" unless has_history?
    @@mutex.synchronize {
      self.clear
      @__gibble__ = @__gibbles__[:order].last
      self.merge! @__gibbles__[:objects][ @__gibble__ ]
    }
    @__gibble__
  end
end

class Gibbler::Array
  def gibble_revert
    raise "No history (#{self.class})" unless has_history?
    @@mutex.synchronize {
      self.clear
      @__gibble__ = @__gibbles__[:order].last
      self.push *(@__gibbles__[:objects][ @__gibble__ ])
    }
    @__gibble__
  end
end
  
class Gibbler::String
  def gibble_revert
    raise "No history (#{self.class})" unless has_history?
    @@mutex.synchronize {
      self.clear
      @__gibble__ = @__gibbles__[:order].last
      self << (@__gibbles__[:objects][ @__gibble__ ])
    }
    @__gibble__
  end
end
      

