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
    