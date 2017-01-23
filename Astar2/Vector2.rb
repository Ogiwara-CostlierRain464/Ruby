class Vector2
  attr_accessor :x
  attr_accessor :y
  def initialize(x,y)
    @x = x
    @y = y
  end
  def front; Vector2.new(@x,@y-1) end
  def back; Vector2.new(@x,@y+1) end
  def left; Vector2.new(@x-1,@y) end
  def right; Vector2.new(@x+1,@y) end
end
#finish