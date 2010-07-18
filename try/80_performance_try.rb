## DISABLED. Tryouts 2.0 doesn't do performance
##
# 
# library :gibbler, File.dirname(__FILE__), '..', 'lib'
# group "Performance"
# 
# tryouts "Speed", :benchmark do
#   # NOTE: gibbler is slower when history is enabled. 
#   drill "Setup variables" do
#     @@array = (1..1000).map { rand }
#     values = (1..1000).map { rand }
#     zipped = @@array.zip(values)
#     @@hash = Hash[*zipped]
#   end
#   
#   drill "Array#hash", 5 do
#     @@array.hash
#   end 
#   
#   
# #  dream :mean, 0.21
#   drill "Array#gibbler", 5 do
#     @@array.gibbler 
#   end
#   
#   drill "Hash#hash", 5 do
#     @@hash.hash
#   end
#   
# #  dream :mean, 1.4
#   drill "Hash#gibbler", 5 do
#     @@hash.gibbler 
#   end
#   
# end
# 
# repetitions = 10         # at 100_000 hash shows errors
# sample_size = 1..100
# 
# tryouts "Uniqueness", :api do
#   
#   drill "Array#hash, all unique", 0 do
#     seen = []
#     repetitions.times do
#       srand
#       seen << ((sample_size).map { rand }).hash
#     end
#     seen.size - seen.uniq.size
#   end
#   
#   drill "Hash#hash, all unique", 0 do
#     seen = []
#     repetitions.times do
#       srand
#       seen << Hash[*(sample_size).map { rand }.zip((sample_size).map { rand })].hash
#     end
#     seen.size - seen.uniq.size
#   end
#   
#   drill "Array#gibbler, all unique", 0 do
#     seen = []
#     repetitions.times do
#       srand
#       seen << ((sample_size).map { rand }).gibbler 
#     end
#     seen.size - seen.uniq.size
#   end
#   
#   drill "Hash#gibbler, all unique", 0 do
#     seen = []
#     repetitions.times do
#       srand
#       seen << Hash[*(sample_size).map { rand }.zip((sample_size).map { rand })].gibbler 
#     end
#     seen.size - seen.uniq.size
#   end
#   
#   
#   
#   
#   
# end