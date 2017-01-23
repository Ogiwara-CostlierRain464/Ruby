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