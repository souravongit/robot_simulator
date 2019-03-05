class Robot
  attr_accessor :current_position

  def initialize
    self.current_position = nil
  end

  def placed?
    !current_position.nil?
  end

  def place(table, position)
    if table.is_valid_position?(position)
      self.current_position = position 
    else
      "Invalid coordinates. Table Size is 5X5!"
    end
  end

  def right
    if placed?
      self.current_position = Position.new({x: current_position.x,
        y: current_position.y,
        direction: current_position.direction_right})
    else
      "Please place your robot first!"
    end
  end

  def left
    if placed?
      self.current_position = Position.new({x: current_position.x,
        y: current_position.y,
        direction: current_position.direction_left})
    else
      "Please place your robot first!"
    end
  end

  def move(table)
    if placed?
      new_position = current_position.move_towards(current_position.direction)
      if table.is_valid_position?(new_position)
        self.current_position = new_position 
      else
        "Invalid coordinate!"
      end
    else
      "Please place your robot first!"
    end
  end

  def report
    if !placed?
      'Robot not placed!'
    else
      [current_position.x, current_position.y, current_position.direction].join(',')
    end
  end
end