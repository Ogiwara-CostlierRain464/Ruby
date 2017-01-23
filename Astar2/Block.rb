require './Vector2.rb'

module TYPE
  ROAD = 0
  WALL = 1
  PASSED = 2
end

class Block < Vector2
  attr_accessor :type
  attr_accessor :cost
  def initialize(type,cost,vec)
    @type = type
    @cost = cost
    super(vec.x,vec.y)
  end
end
#finish