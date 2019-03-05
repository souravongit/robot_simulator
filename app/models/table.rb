class Table
  attr_accessor :length, :width

  def initialize(options)
    self.length = options[:length]
    self.width  = options[:width]
  end

  # Check position value within table length and width also check position values are not less than zero 
  def is_valid_position?(position)
    position.x < length && position.y < width && position.x >= 0 && position.y >= 0
  end
end
