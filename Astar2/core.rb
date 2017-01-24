require './Stage.rb'
require 'benchmark'
result = Benchmark.realtime do
  Stage.new.process
end
puts "Took #{result}s"