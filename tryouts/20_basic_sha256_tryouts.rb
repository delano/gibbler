
library :gibbler, File.dirname(__FILE__), '..', 'lib'
group "Gibbler Gazette"

Gibbler.enable_debug if Tryouts.verbose > 3


tryouts "Basic syntax with SHA256" do
  
  setup do
    # NOTE: JRuby requires that we use OpenSSL::Digest::SHA256
    if Tryouts.sysinfo.vm == :java 
      require 'openssl'
      Gibbler.digest_type = OpenSSL::Digest::SHA256
    else
      Gibbler.digest_type = Digest::SHA256
    end
    
  end
  
  clean do
    Gibbler.digest_type = Digest::SHA1
  end
  
  dream :gibbler, '754f87ca720ec256633a286d9270d68478850b2abd7b0ae65021cb769ae70c08' 
  drill "A Symbol can gibbler", :anything
  
  dream :gibbler, 'e81018430223e309ed7fb4d4c41aa5435386f825af7d7859ef19a95fb1a7a1be' 
  drill "Class can gibbler", Class
  
  dream :gibbler, '0f0c65cf97e7b2e37b4030a77cfda347bc646ac70ae6c3eab3506b43fc17f243' 
  drill "TrueClass can gibbler", TrueClass
  
  dream :gibbler, '88d2bcbd68ce593fd2e0e06f276f7301357516291b95c0c53038e61a9bf091e5' 
  drill "Empty Hash instance", {}
  
end



