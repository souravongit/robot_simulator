class Command
  attr_accessor :robot, :table

  def initialize(options)
    self.robot = options[:robot]
    self.table = options[:table]
  end

  # Parse command and invoke instance method of robot accordingly
  # For PLACE command format the value from the sting to initialize position with appropriate value
  def execute(command)
    if command =~ /^PLACE\s+\d+\s*,\s*\d+\s*,\s*(NORTH|SOUTH|EAST|WEST)$/
      command, x, y, direction = command.gsub(',', ' ').split
      robot.place(table, Position.new({x: x.to_i, y: y.to_i, direction: direction}))
    elsif command == "MOVE"
      robot.move(table)
    elsif command == "LEFT"
      robot.left
    elsif command == "RIGHT"
      robot.right
    elsif command == "REPORT"
      robot.report
    else
      "Invalid command!"
    end
  end
end
