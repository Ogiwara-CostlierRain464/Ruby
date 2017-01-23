class Address
  def initialize(x,y)
    @x = x
    @y= y
  end

  def x;@x end
  def y;@y end
end

class Card < Address
  def initialize(number,x,y)
    super(x,y)
    @number = number
  end

  def number;@number end
end

class Player
  def initialize
    @point = 0
  end

  def addpoint
    @point += 1
  end

  def getpoint
    @point
  end
end

class Board
  def initialize(weight,height,playercount)
    @height = height
    @weight = weight
    @players = Array.new
    playercount.times do |i|
      @players.push(Player.new)
    end
    @currentplayer = 0
    @cards = Array.new
  end

  def add_card(card)
    @cards.push(card)
  end

  def process(address1,address2)
    if (getnumber(address1) == getnumber(address2))
      @players[@currentplayer].addpoint
      puts "point"
    else
      nextplayer
      puts "next"
    end
  end

  def getnumber(address)
    @cards.each do |e|
      if (e.x == address.x && e.y == address.y)
        return e.number
      end
    end
  end

  def nextplayer
    @currentplayer = @players[@currentplayer+1].nil? ? 0 : @currentplayer+1
  end

  def showresult
    @players.each do |e|
      puts (e.getpoint)*2
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
  e.each_with_index do |e1,i1|
    card = Card.new(e1,i1+1,i+1)
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