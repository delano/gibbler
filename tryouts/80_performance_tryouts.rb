
library :gibbler, File.dirname(__FILE__), '..', 'lib'
group "Performance"

tryouts "Speed", :benchmark do
  # NOTE: gibble is slower when history is enabled. 
  drill "Setup variables" do
    @@array = (1..10000).map { rand }
    values = (1..10000).map { rand }
    zipped = @@array.zip(values)
    @@hash = Hash[zipped]
  end
  
  drill "Array#hash", 5 do
    @@array.hash
  end 
  
  
  dream :mean, 0.2
  drill "Array#gibble", 5 do
    @@array.gibble 
  end
  
  drill "Hash#hash", 5 do
    @@hash.hash
  end
  
  dream :mean, 1.0
  drill "Hash#gibble", 5 do
    @@hash.gibble 
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
  
  drill "Array#gibble, all unique", 0 do
    seen = []
    repetitions.times do
      srand
      seen << ((sample_size).map { rand }).gibble 
    end
    seen.size - seen.uniq.size
  end
  
  drill "Hash#gibble, all unique", 0 do
    seen = []
    repetitions.times do
      srand
      seen << Hash[(sample_size).map { rand }.zip((sample_size).map { rand })].gibble 
    end
    seen.size - seen.uniq.size
  end
  
  
  
  
  
end