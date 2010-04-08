
library :gibbler, 'lib'

group "Instance Digests"




tryouts "Instance Digests" do
  if Tryouts.sysinfo.vm == :java 
    require 'openssl'
    sha256 = OpenSSL::Digest::SHA256
    md5 = OpenSSL::Digest::MD5
  else
    sha256 = Digest::SHA256
    md5 = Digest::MD5
  end
  
  class ::FullHouse
    include Gibbler::Complex
    attr_accessor :roles
  end
  
  dream 'a937ac8dc027a23e45cd20539189e9c8554857a603df8d838238943f9dc078d3'
  drill "can specify SHA256 digest type for String" do
    "kimmy".gibbler sha256
  end
  
  dream '1069428e6273cf329436c3dce9b680d4d4e229d7b71ccf4adfe975c6fac8880b'
  drill "can specify SHA256 digest type for Symbol" do
    :kimmy.gibbler sha256
  end
  
  dream '831ee62f99a15a143db15e3ad5dea5c1'
  drill "can specify MD5 digest type for String" do
    "kimmy".gibbler md5
  end
  
  dream '2c0da7d02c4262af67687878660b75f9'
  drill "can specify MD5 digest type for FullHouse" do
    FullHouse.new.gibbler md5
  end
  
  

end

