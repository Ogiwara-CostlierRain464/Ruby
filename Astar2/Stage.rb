require './Block.rb'
require './Player.rb'
=begin
A-starアルゴリズム(?)
 ^
 Y
  01234567

  11111111 0
  10000000 1
  10111011 2
  10111011 3
  10000011 4
  10111111 5
  10111111 6
  11111111 7 X->
0: 空きスペース
1: 壁
2: 探索済み

通った道にマークする
=end

module GAME_RESULT
  GAMING = 0
  GAME_OVER = 1
  GAME_CLEAR = 2
end

class Stage
  attr_accessor :map
  attr_accessor :players
  attr_accessor :blocks
  attr_accessor :start_pos
  attr_accessor :end_pos
  attr_accessor :status
  attr_accessor :winner

  def initialize
    @@instance = self
    @map = [[1,1,1,1,1,1,1,1],
            [1,1,1,1,0,0,0,1],
            [0,1,1,1,0,0,1,1],
            [0,0,0,1,0,0,0,1],
            [1,1,0,1,1,0,1,1],
            [0,0,0,0,0,0,1,1],
            [1,1,0,1,1,1,1,1],
            [1,0,0,1,1,1,1,1]]
    @players = Array.new
    @winner = nil
    @status = GAME_RESULT::GAMING
    load_map
  end

  def self.get_instance
    @@instance
  end

  def process
    adam = Player.new(@start_pos)
    adam.process_life()
    while @status == GAME_RESULT::GAMING
      min = 999
      nextplayer = nil
      counter = 0
      @players.each do |e|
        if ((n = get_block(e).cost) < min and e.alive)
          min = n
          nextplayer = e
          counter += 1
        end
        #print_stage()
      end
      @status = GAME_RESULT::GAME_OVER if counter == 0
     nextplayer.process_life()
    end
    puts "finished!"
    puts "GAMEOVER" if @status == GAME_RESULT::GAME_OVER
    puts "CLEAR" if @status == GAME_RESULT::GAME_CLEAR
    print_stage()
    print_winner_route()
  end

  def get_block(vec)
    @blocks.each do |e|
      if(e.x==vec.x and e.y==vec.y)
        return e
      end
    end
  end

  def load_map
    @start_pos = Vector2.new(2,5);@end_pos = Vector2.new(6,1)
    @blocks = Array.new
    @map.each_with_index do |y_blocks,y|
      y_blocks.each_with_index do |type,x|
        vec = Vector2.new(x,y)
        @blocks.push(Block.new(type,calculate_cost(@end_pos,vec),vec))
      end
    end
  end

  def print_stage
    @blocks.each_with_index do |e,i|
      print "#{e.type} "
      puts("") if (i+1)%8 == 0
    end
  end

  def print_winner_route
    puts "Routes:"
    @winner.route.each do |e|
      puts e
    end
  end

  def calculate_cost(vec1,vec2); ((vec2.x - vec1.x).abs)**2 + ((vec2.y - vec1.y).abs)**2 end
end