
library :gibbler2, File.dirname(__FILE__), '..', 'lib'
group "Performance"

tryouts "Object#gibbler", :benchmark do
  
  drill "Setup variables" do
    @@array = (1..10000).map { rand }
    values = (1..10000).map { rand }
    zipped = @@array.zip(values)
    @@hash = Hash[zipped]
  end
  
  dream :ne, Object
  drill "gibbler", 15 do
    @@array.gibbler
  end
  
  drill"hash", 15 do
    @@array.hash
  end 
  

end


tryouts "Object#hash", :benchmark do
  
  
end