
library :gibbler, 'lib'

group "Mixins"

tryouts "String" do
  
  drill "has String#clear" do
    "".respond_to? :clear
  end
  
end

