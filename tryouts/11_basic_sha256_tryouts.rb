
library :gibbler, File.dirname(__FILE__), '..', 'lib'
group "Gibbler Gazette"

Gibbler.enable_debug if Tryouts.verbose > 3


tryouts "Basic syntax with SHA256" do
  
  # NOTE: JRuby require that we use OpenSSL::Digest::SHA256
  if Tryouts.sysinfo.vm == :java 
    drill "Can change Digest type", OpenSSL::Digest::SHA256 do
      Gibbler.digest_type = OpenSSL::Digest::SHA256
    end
  else
    drill "Can change Digest type", Digest::SHA256 do
      Gibbler.digest_type = Digest::SHA256
    end
  end
  
  dream :respond_to?, :gibbler
  dream :gibbler, '754f87ca720ec256633a286d9270d68478850b2abd7b0ae65021cb769ae70c08' 
  drill "A Symbol can gibbler", :anything
  
  dream :respond_to?, :gibbler
  dream :gibbler, 'd345c0afb4e8da0133a3946d3bd9b2622b0acdd8d6cc1237470cc637a9e4777f' 
  drill "Class can gibbler", Class
  
  dream :respond_to?, :gibbler
  dream :gibbler, '88d2bcbd68ce593fd2e0e06f276f7301357516291b95c0c53038e61a9bf091e5' 
  drill "Empty Hash instance", {}
  
  drill "Can return Digest type", Digest::SHA1 do
    Gibbler.digest_type = Digest::SHA1
  end
  
end



