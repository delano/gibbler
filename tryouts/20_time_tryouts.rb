

library :gibbler, 'lib'
group "Gibbler Gazette"

Gibbler.enable_debug if Tryouts.verbose > 3
Gibbler.digest_type = Digest::SHA1

tryouts "Time tryouts" do
  
  dream :gibbler, 'c8403fc35481fdf7f6f4a0e7262b1c9610bdebaa'
  drill "Date instance can gibbler", Date.parse('2009-08-25')
  
  dream :gibbler, '73b4635fc63b8dd32b622776201f98a37478be90'
  drill "Time instance can gibbler", Time.parse('2009-08-25 16:43:53 UTC')

  dream :gibbler, 'ad64c7694a50becf55c53485dce5d0013ff65785'
  drill "DateTime instance can gibbler", DateTime.parse('2009-08-25T17:00:40+00:00')
  
  
  dream Time.parse('2009-08-25 12:43:53 -04:00').gibbler
  drill "Time digest is based on UTC" do
    Time.parse('2009-08-25 16:43:53 UTC').gibbler
  end
  
  dream DateTime.parse('2009-08-25T13:00:40-04:00').gibbler
  drill "DateTime digest is based on UTC" do
    DateTime.parse('2009-08-25T17:00:40+00:00').gibbler
  end
  
end