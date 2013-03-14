require_relative "battleship.rb"

class TestBattleship
  def self.test_coords
    ship = Ship.new(1,1,"h",3)

    assert(ship.coords == [[1,1], [1,2], [1,3]])
  end

  def self.test_hit_hit
    ship = Ship.new(1,1,"h",3)

    assert ship.hit(1,1)
  end

  def self.test_hit_miss
    ship = Ship.new(1,1,"h",3)

    assert !ship.hit(9,9)
  end

  def self.test_hit_state_change
    ship = Ship.new(1,1,"h",3)
    ship.hit(1,1)

    assert ship.hits == [[1,1]]
  end

  def self.test_hit_duplicate
    ship = Ship.new(1,1,"h",3)
    ship.hit(1,1)

    assert_raise Ship::DuplicateHitError do
      ship.hit(1,1)
    end
  end

  def self.test_sunk_true
    ship = Ship.new(1,1,"h",3)
    ship.hits = [[1,1], [2,1], [3,1]]

    assert ship.sunk?
  end

  def self.test_sunk_false
    ship = Ship.new(1,1,"h",3)
    ship.hits = [[1,1], [2,1]]

    assert !ship.sunk?
  end

  def self.test_mark_board_duplicate_shot
    battleship = Battleship.new
    battleship.boards[0][0][0] = "!"

    assert_raise Battleship::DuplicateShotError do
      battleship.mark_board(0,0)
    end
  end

  def self.test_mark_board_out_of_bounds
    battleship = Battleship.new

    assert_raise ArgumentError do
      battleship.mark_board(10,10)
    end
  end

  def self.assert expr
    puts expr ? "Pass #{caller.first}" : "Fail #{caller.first}"
  end

  def self.assert_raise error_class, &block
    yield
    puts "Fail #{caller.first}"

  rescue error_class
    puts "Pass #{caller[1]}"
  end
end

if __FILE__ == $0
  TestBattleship.methods.grep(/test_/).each{|method| TestBattleship.send method }
end
