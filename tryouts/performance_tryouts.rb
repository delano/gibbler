
library :gibbler, File.dirname(__FILE__), '..', 'lib'
group "Performance"

tryouts "Speed", :benchmark do
  
  drill "Setup variables" do
    @@array = (1..10000).map { rand }
    values = (1..10000).map { rand }
    zipped = @@array.zip(values)
    @@hash = Hash[zipped]
  end
  
  drill "Array#hash", 15 do
    @@array.hash
  end 
  drill "Array#gibbler", 15 do
    @@array.gibbler
  end
  
  drill "Hash#hash", 15 do
    @@hash.hash
  end
  drill "Hash#gibbler", 15 do
    @@hash.gibbler
  end
  
end

repetitions = 100         # at 100_000 hash shows errors
sample_size = 1..100

tryouts "Uniqueness", :api do
  
  drill "Array#hash, all unique", 0 do
    seen = []
    repetitions.times do
      srand
      seen << ((sample_size).map { rand }).hash
    end
    seen.size - seen.uniq.size
  end
  
  drill "Hash#hash, all unique", 0 do
    seen = []
    repetitions.times do
      srand
      seen << Hash[(sample_size).map { rand }.zip((sample_size).map { rand })].hash
    end
    seen.size - seen.uniq.size
  end
  
  drill "Array#gibbler, all unique", 0 do
    seen = []
    repetitions.times do
      srand
      seen << ((sample_size).map { rand }).gibbler
    end
    seen.size - seen.uniq.size
  end
  
  drill "Hash#gibbler, all unique", 0 do
    seen = []
    repetitions.times do
      srand
      seen << Hash[(sample_size).map { rand }.zip((sample_size).map { rand })].gibbler
    end
    seen.size - seen.uniq.size
  end
  
  
  
  
  
end