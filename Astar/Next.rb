require './Vector2.rb'
require './Stage.rb'

#映画 NEXTにちなんで
class NEXT < Vector2
  def initialize(vec)
    @alive = true
    @stage = Stage.getInstance
    super(vec.x,vec.y);
  end

  def isAlive?;@alive end

  def kill; @alive = false end

  def step
    @stage.set_passed(self)
    branches = get_possible_to_go
    if branches.length == 0
      if @stage.is_goal?(self)
        @stage.set_goal
      else
        kill
      end
    else
      branches.each do |e|
        @stage.add_next(NEXT.new(e.x,e.y))
      end
    end
  end

  def get_possible_to_go
    f = front; b = back; l = left; r = right
    branchs = Array.new
    branchs.push(f) if @stage.can_pass?(f)
    branchs.push(b) if @stage.can_pass?(b)
    branchs.push(l) if @stage.can_pass?(l)
    branchs.push(r) if @stage.can_pass?(r)
    return branchs
  end
end