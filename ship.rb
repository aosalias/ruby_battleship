class Ship
  SHIPS = [2]#[2,3,3,4,5]
  attr_accessor :hits

  class DuplicateHitError < StandardError; end

  def initialize(x, y, direction, length)
    @x, @y, @direction, @length = x, y, direction, length
    @hits = []
  end

  def coords
    coords = []

    @length.times do |i|
      x = @direction == "v" ? @x + i : @x
      y = @direction == "h" ? @y + i : @y
      coords << [x,y]
    end

    coords
  end

  def hit(x, y)
    raise DuplicateHitError if @hits.include? [x,y]

    if coords.include? [x,y]
      @hits << [x,y]
      true
    end
  end

  def sunk?
    @hits.size == @length
  end
end
