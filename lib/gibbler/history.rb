


module Gibbler
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
    
    def gibble_revert
      raise "Revert is not implement for #{self.class}"
    end
    
  end
  
  
end
