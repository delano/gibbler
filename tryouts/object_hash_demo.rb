
library :gibbler, File.dirname(__FILE__), '..', 'lib'
group "Object#hash"

tryout "Object#hash (Ruby 1.9 only)", :api do
    
  drill "Object", Object.hash, 1892070
  drill "Class", Class.hash, 1892030
  drill "Array", Array.hash, 1866770
  drill "Hash", Hash.hash, 1863840
  
end

tryouts "Object#hash (Ruby 1.8 only)", :api do
  
  drill "Object", Object.hash, 118420
  drill "Class", Class.hash, 118400
  drill "Array", Array.hash, 104100
  drill "Hash", Hash.hash, 102590
  
end

tryouts "Object#hash (JRuby only)", :api do
  
  drill "Object", Object.hash, 1
  drill "Class", Class.hash, 3
  drill "Array", Array.hash, 46
  drill "Hash", Hash.hash, 43
  
end
