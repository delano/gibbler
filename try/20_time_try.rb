require 'date'
require 'gibbler'

# "Date instance can gibbler
  Date.parse('2009-08-25').gibbler
#=> 'c8403fc35481fdf7f6f4a0e7262b1c9610bdebaa'

# "Time instance can gibbler
  Time.parse('2009-08-25 16:43:53 UTC').gibbler
#=> '73b4635fc63b8dd32b622776201f98a37478be90'

# "Time instance can gibbler with single digit values
  Time.parse('2009-01-01 01:01:01 UTC').gibbler
#=> 'd35546d6517c02f2a219ecfa2261a5274d217cb7'

# "DateTime instance can gibbler
  DateTime.parse('2009-08-25T17:00:40+00:00').gibbler
#=> 'ad64c7694a50becf55c53485dce5d0013ff65785'

# "Time digest is based on UTC
  Time.parse('2009-08-25 16:43:53 UTC').gibbler
#=> Time.parse('2009-08-25 12:43:53 -04:00').gibbler

# "DateTime digest is based on UTC
  DateTime.parse('2009-08-25T17:00:40+00:00').gibbler
#=> DateTime.parse('2009-08-25T13:00:40-04:00').gibbler

