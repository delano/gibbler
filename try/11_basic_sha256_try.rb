require 'gibbler'

# NOTE: JRuby requires that we use OpenSSL::Digest::SHA256
if Tryouts.sysinfo.vm == :java 
  require 'openssl'
  Gibbler.digest_type = OpenSSL::Digest::SHA256
else
  Gibbler.digest_type = Digest::SHA256
end

## A Symbol can gibbler
  :anything.gibbler
#=> '754f87ca720ec256633a286d9270d68478850b2abd7b0ae65021cb769ae70c08' 

## Class can gibbler
  Class.gibbler
#=> 'd345c0afb4e8da0133a3946d3bd9b2622b0acdd8d6cc1237470cc637a9e4777f' 

## TrueClass can gibbler
  TrueClass.gibbler
#=> 'b7b874a9bff7825caa57750a900652354ac601b77497b694d313f658c69d25b4' 

# Empty Hash instance
  {}.gibbler
#=> '88d2bcbd68ce593fd2e0e06f276f7301357516291b95c0c53038e61a9bf091e5' 

Gibbler.digest_type = Digest::SHA1

