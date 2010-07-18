require 'gibbler'

class ::MyProc < Proc; end

## Proc.new can gibbler
  Proc.new() { }.gibbler
#=> '12075835e94be34438376cd7a54c8db7e746f15d' 

# Proc can gibbler
  Proc.gibbler
#=> '8640f7abcbcb80e3825ed827bf36819e26119e16' 
  
## proc can gibbler
  proc {}.gibbler
#=> '12075835e94be34438376cd7a54c8db7e746f15d' 

# lambda can gibbler
  lambda {}.gibbler
#=> '12075835e94be34438376cd7a54c8db7e746f15d' 

# lambda gibbler is not aware of arity
  lambda { |v| }.gibbler
#=> '12075835e94be34438376cd7a54c8db7e746f15d' 

# proc gibbler is not aware of arity
  proc { |v| }.gibbler
#=> '12075835e94be34438376cd7a54c8db7e746f15d' 

# Proc gibbler is not aware of proc payload"
  proc { |v| 1; }.gibbler
#=> '12075835e94be34438376cd7a54c8db7e746f15d' 

# MyProc has a different digest
  MyProc.new() { }.gibbler
#=> "c979a45653acaddcb9c1581a7de49c94ac96e128"
