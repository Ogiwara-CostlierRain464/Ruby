require './Vector2.rb'
require './Stage.rb'

#一歩歩くと死ぬ
#次に行く場所が保存
class Player < Vector2
  attr_accessor :alive
  attr_accessor :route

  def initialize(vec,route=Array.new)
    @alive = true
    @stage = Stage.get_instance
    @route = route
    super(vec.x,vec.y)
    if(vec.x == @stage.end_pos.x && vec.y == @stage.end_pos.y)
      @stage.status = GAME_RESULT::GAME_CLEAR
      @stage.winner = self
    end
  end

  def process_life
    make_sons()
    @route.push(Vector2.new(@x,@y))
    @stage.get_block(self).type = TYPE::PASSED
    @alive = false#death
  end

  def make_sons
    f = front(); b = back(); l = left(); r = right()
    @stage.players.push(Player.new(f,@route.clone)) if @stage.get_block(f).type == TYPE::ROAD
    @stage.players.push(Player.new(b,@route.clone)) if @stage.get_block(b).type == TYPE::ROAD
    @stage.players.push(Player.new(l)) if @stage.get_block(l).type == TYPE::ROAD
    @stage.players.push(Player.new(r)) if @stage.get_block(r).type == TYPE::ROAD
  end
end