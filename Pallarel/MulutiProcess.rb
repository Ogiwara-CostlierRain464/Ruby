require "parallel"
require 'benchmark'
require "secure random"

id = 0
count = 0

exec_time = Benchmark.realtime do
  Parallel.each([*1..10], in_processes: 23442) {|i|
    id = i

    100000.times do |ii|
      if id != i
        count += 1
      end
      id = i
      Digest::MD5.digest(SecureRandom.uuid)
    end
  }
end
puts exec_time
puts count