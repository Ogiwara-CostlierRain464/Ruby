require 'benchmark'
require 'securerandom'

exectime = Benchmark.realtime do
  [*1..10].each do |i|
    10000.times do |ii|
      Digest::MD5.digest(SecureRandom.uuid)
    end
  end
end
puts exectime