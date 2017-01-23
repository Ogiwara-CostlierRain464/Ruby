class Amida
  def initialize(distance,line,bridge_count)
    @distance = distance
    @line = line
    @bridges = Array.new
  end

  def process
    p = Player.new
    until p.y == @distance
      if (b = has_bridge(p.x,p.y))
        p.warp(b)
      else
        p.step
      end
    end
    puts p.x
  end

  def add_bridge(bridge)
    @bridges.push(bridge)
  end

  def has_bridge(x,y)
    @bridges.each do |e|
      if (e.from.x == x && e.from.y == y)
        return e.to
      end
      if (e.to.x == x && e.to.y == y)
        return e.from
      end
    end
    false
  end
end

class Bridge
  def initialize(address1,address2)
    @from = address1
    @to = address2
  end

  def from
    @from
  end
  def to
    @to
  end
end

class Address
  def initialize(x,y)
    @x = x
    @y = y
  end

  def x
    @x
  end

  def y
    @y
  end
end

class Player < Address
  def initialize
    super(1,0)
  end

  def warp(address)
    @x = address.x
    @y = address.y
    step
  end

  #ただ前進
  def step
    @y += 1
  end
end

amida_data = gets.chomp.split("").map{|e| e.to_i}
bridges = Array.new(amida_data[2])
amida_data[2].times do |i|
  bridges[i] = gets.split("").map{|e| e.to_i}
end
amida = Amida.new(amida_data[0],amida_data[1],amida_data[2])
bridges.each do |e|
  amida.add_bridge(Bridge.new(Address.new(e[0],amida_data[0]-e[1]),Address.new(e[0]+1,amida_data[0]-e[2])))
end
amida.process
