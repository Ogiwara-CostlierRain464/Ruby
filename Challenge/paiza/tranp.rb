class Address
  def initialize(x,y)
    @x = x
    @y= y
  end

  def x;@x end
  def y;@y end
end

class Tranp < Address
  def initialize(number,x,y)
    super(x,y)
    @number = number
  end

  def number;@number end
end

class Board
  def initialize(weight,height,number)
    @height = height#高さ
    @weight = weight#幅
    @players = Array.new(number)
    @players = @players.map {|e| e = 0}
    @tranps = Array.new
    @currentplayer = 1#一人目
  end

  def add_card(tranp)
    @tranps.push(tranp)
  end

  def process(address1,address2)
    if (getnumber(address1) == getnumber(address2) && getnumber(address1) != 99)
      p @players
      @players[@currentplayer-1] += 1
    else
      nextplayer
      puts "next"
    end
  end

  def getnumber(address)
    @tranps.each do |e|
      if (e.x == address.x && e.y == address.y)
        return e.number
      end
    end
    99
  end

  def showresult
    @players.each { |e|
      puts (e*2)
    }
  end

  def nextplayer
    @currentplayer += 1
    if @currentplayer > @players.count
      @currentplayer = 1
    end
  end
end

input = gets.split(' ').map{|e| e.to_i } #2 2 2
board = Board.new(input[0],input[1],input[2])
cards = Array.new
input[0].times do |i|
  cards.push(gets.split(' ').map{|e| e.to_i })# [1,2]
end
cards.each_with_index do |e,i|
  puts e
  e.each_with_index do |e1,i1|
    card = Tranp.new(e1,i1+1,i+1)
    board.add_card(card)
  end
end

processcount = gets.to_i
processcount.times do |i|
  sp = gets.split(' ').map{|e| e.to_i }
  add1 = Address.new(sp[0],sp[1])
  add2 = Address.new(sp[2],sp[3])
  board.process(add1,add2)
end

board.showresult

