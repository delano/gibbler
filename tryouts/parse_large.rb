#!/usr/bin/ruby
# 
# Large array speed test
#
# Usage:
#
#     $ ruby tryouts/parse_large.rb [rubygems]
# 
# If "rubygems" is specified, it will use the system version 
# of gibbler rather than the local development copy. 
#

unless ARGV.first == 'rubygems'
  puts "Testing Rubygems version"
  $:.unshift File.join(File.dirname(__FILE__), '..', 'lib')
else
  puts "Testing local dev version"
end

require 'gibbler'
require 'benchmark'

bigstr = File.readlines('tryouts/data.csv')
bigarr = bigstr.collect { |l| l.split(',') }


Benchmark.bm(5) do |x|
  x.report("array of strings (#{bigstr.size}): ")   { bigstr.gibbler }
  x.report("array of arrays  (#{bigarr.size}): ")   { bigarr.gibbler }
end
    
__END__

$ ruby tryouts/parse_large.rb rubygems
Testing local dev version
           user     system      total        real
array of strings (119540):   2.960000   0.090000   3.050000 (  3.065106)
array of arrays  (119540):   8.360000   0.110000   8.470000 (  8.504949)

$ ruby tryouts/parse_large.rb 
Testing Rubygems version
           user     system      total        real
array of strings (119540):   1.640000   0.070000   1.710000 (  1.722648)
array of arrays  (119540):   5.260000   0.110000   5.370000 (  5.387211)

