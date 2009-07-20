library :gibbler, 'lib'
group "Gibbler Gazette"

Gibbler.enable_debug if Tryouts.verbose > 3

tryouts "Gibbler::Complex gibbler_ignore" do
  
  dream :respond_to?, :gibbler_ignore
  drill "objects have a gibbler_ignore method" do
    Class.new.send :include, Gibbler::Complex
  end
  
  dream :respond_to?, :__gibbler_ignore
  drill "objects have __gibbler_ignore in the attic" do
    Class.new.send :include, Gibbler::Complex
  end
  
  dream true
  drill "can store ivar names to __gibbler_ignore" do
    class A
      include Gibbler::Complex
      gibbler_ignore :name
    end
    A.__gibbler_ignore
  end
  
end