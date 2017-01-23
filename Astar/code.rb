#coding: utf-8
=begin
A-starアルゴリズム(まだダイクストラです…)
 ^
 Y
  01234567

  11111111 0
  10000003 1
  10111011 2
  10111011 3
  10000011 4
  10111111 5
  12111111 6
  11111111 7 X->
0: 空きスペース
1: 壁
2: スタート
3: ゴール

通った道にマークする
4: 通った道
=end

module TYPE
  ROAD = 0
  WALL = 1
  START = 2
  GOAL = 3
  PASSED = 4
end

class Vector2
  def initialize(x,y)
    @x = x
    @y = y
  end
  def x;@x end
  def y;@y end

  def front; Vector2.new(@x,@y-1) end
  def back; Vector2.new(@x,@y+1) end
  def left; Vector2.new(@x-1,@y) end
  def right; Vector2.new(@x+1,@y) end
end

class Block < Vector2
  def initialize(type,x,y)
    @type = type
    super(x,y);
  end

  def settype(type)
    @type = type
  end

  def can_pass?
    @type == TYPE.ROAD ? true : false
  end
end

#映画 NEXTにちなんで
class NEXT < Vector2
  def initialize(x,y)
    @alive = true
    @stage = Stage.getInstance
    super(x,y);
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

class Stage
  def initialize
    @blocks = [
        [1,1,1,1,1,1,1,1],
        [1,1,1,1,1,1,0,0],
        [1,1,1,1,1,1,1,1],
        [1,1,1,1,1,1,1,1],
        [1,1,1,1,1,1,1,1],
        [1,1,1,1,1,1,1,1],
        [1,0,1,1,1,1,1,1],
        [1,1,1,1,1,1,1,1]
    ]
    @start = Vector2.new(1,6); @end = Vector2.new(7,1)
    @gameover = false; @gameclear = false
    @nexts = Array.new
    @@instance = self
  end

  def process
    while(@gameover == false and @gameclear == false)
      first = NEXT.new(@start.x,@start.y)
      first.step
      counter = 0
      @nexts.each {|e|
        if e.isAlive?
          counter += 1
          e.step
        end
      }
      set_over if counter == 0
    end
    puts "finished!"
    puts "GAMEOVER" if @gameover
    puts "CLEAR" if @gameclear
    printstage
  end

  def self.getInstance;@@instance end

  def get_block(vec)
    a = @blocks[vec.y][vec.x]
    a.nil? ? TYPE::WALL : a
  end
  def can_pass?(vec); get_block(vec) == TYPE::ROAD ? true : false end
  def set_passed(vec); @blocks[vec.y][vec.x] = TYPE::PASSED end
  def add_next(ne); @nexts.push(ne) end
  def is_goal?(vec)
    if(vec.x == @end.x and vec.y == @end.y)
      true
    else
      false
    end
  end
  def set_goal; @gameclear = true end
  def set_over; @gameover = true end

  def printstage
    @blocks.each do |e|
      print(e)
      print("\n")
    end
  end

end

Stage.new.process
