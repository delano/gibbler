
library :gibbler, 'lib'
group "Gibbler Gazette"

Gibbler.enable_debug if Tryouts.verbose > 3

tryouts "Can define digest fields" do
  
  dream [:name, :email]
  drill "can define digest attributes via class method" do
    class ::Person 
      include Gibbler::Complex
      gibbler :name, :email
      def initialize(n,e) @name, @email = n, e end
    end
    a = Person.new "Delano", "delano@localhost"
    a.gibbler_fields
  end
  
  dream '3d512f667e6b0f717aa6c06e1a0973e0d924e428'
  drill "will generate digest based on attributes" do
    a = Person.new "Delano", "delano@localhost"
    a.gibbler
  end
  
  dream '85f85f5c0e28343207dbf38b4d0d98e203ceefe1'
  drill "gibbler fields are copies when inherited" do
    class ::Person2 < Person
    end
    a = Person2.new "Delano", "delano@localhost"
    a.gibbler
  end
  
  dream 'c6b72d9919a96f852ef50b461f638dc40b2fa8d5'
  drill "order is important" do
    class ::Person2 < Person
      gibbler :email, :name
    end
    a = Person2.new "Delano", "delano@localhost"
    a.gibbler
  end
  
end