class Position
  attr_accessor :x, :y, :direction

  DIRECTIONS = ["NORTH", "EAST", "SOUTH", "WEST"].freeze

  def initialize(options)
    self.x = options[:x]
    self.y = options[:y]
    self.direction = options[:direction]
  end

  #Check direction and update position one unit forword towards the direction
  def move_towards(direction)
    case direction
    when 'NORTH'
      move_towards_north_direction
    when 'EAST'
      move_towards_east_direction
    when 'SOUTH'
      move_towards_south_direction
    when 'WEST'
      move_towards_west_direction
    end
  end

  # Return next direction of a given position to the left
  # if given direction is left most element of the array will return last element as direction
  def direction_left
    DIRECTIONS[(DIRECTIONS.index(direction) - 1) % 4]
  end

  # Return next direction of a given position to the right
  # if given direction is right most element of the array will return first element as direction
  def direction_right
    DIRECTIONS[(DIRECTIONS.index(direction) + 1) % 4]
  end

  private
  def move_towards_north_direction
    Position.new({x: x, y: y + 1, direction: direction})
  end

  def move_towards_south_direction
    Position.new({x: x, y: y - 1, direction: direction})
  end

  def move_towards_west_direction
    Position.new({x: x - 1, y: y, direction: direction})
  end

  def move_towards_east_direction
    Position.new({x: x + 1, y: y, direction: direction})
  end
end
