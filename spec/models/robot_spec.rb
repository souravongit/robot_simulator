require 'rails_helper'

RSpec.describe Robot, type: :model do

  let(:robot) { Robot.new }
  let(:table) { Table.new({length: 5, width: 5}) }

  describe '#placed?' do
    context 'when robot not placed' do
      it 'will return false' do
        expect(robot.placed?).to be false
      end
    end

    context 'when robot placed with a coordinate' do
      let(:position) { Position.new({x: 1, y: 2, direction: 'NORTH'}) }

      it 'will return true' do
        robot.place(table, position)
        expect(robot.placed?).to be true
      end
    end
  end

  describe '#place' do
    context 'with valid position' do
      let(:position) { Position.new({x: 1, y: 2, direction: 'NORTH'}) }

      it 'place the robot on correct position' do
        robot.place(table, position)
        expect(robot.current_position).to eq(position)
      end
    end

    context 'with invalid position' do
      let(:position) { Position.new({x: 6, y: 2, direction: 'NORTH'}) }

      it 'will not place robot' do
        expect(robot.place(table, position)).to eq("Invalid coordinates. Table Size is 5X5!")
        expect(robot.current_position).to be nil
      end
    end
  end

  describe '#right' do
    context 'when robot not placed' do
      it 'will return alert message' do
        expect(robot.right).to eq("Please place your robot first!")
      end
    end

    context 'when robot placed' do
      context 'with direction NORTH' do
        let(:position) { Position.new({x: 1, y: 2, direction: 'NORTH'}) }

        it 'after right direction will be change to EAST' do
          robot.place(table, position)
          robot.right
          expect(robot.current_position.direction).to eq("EAST")
        end
      end
      
      context 'with direction EAST' do
        let(:position) { Position.new({x: 1, y: 2, direction: 'EAST'}) }

        it 'after right direction will be change to SOUTH' do
          robot.place(table, position)
          robot.right
          expect(robot.current_position.direction).to eq("SOUTH")
        end
      end

      context 'with direction SOUTH' do
        let(:position) { Position.new({x: 1, y: 2, direction: 'SOUTH'}) }

        it 'after right direction will be change to WEST' do
          robot.place(table, position)
          robot.right
          expect(robot.current_position.direction).to eq("WEST")
        end
      end

      context 'when direction WEST' do
        let(:position) { Position.new({x: 1, y: 2, direction: 'WEST'}) }

        it 'after right direction will be change to NORTH' do
          robot.place(table, position)
          robot.right
          expect(robot.current_position.direction).to eq("NORTH")
        end
      end
    end
  end

  describe '#left' do
    context 'when robot not placed' do
      it 'will return alert message' do
        expect(robot.left).to eq("Please place your robot first!")
      end
    end

    context 'when robot placed' do
      context 'with direction NORTH' do
        let(:position) { Position.new({x: 1, y: 2, direction: 'NORTH'}) }

        it 'after left direction will be change to WEST' do
          robot.place(table, position)
          robot.left
          expect(robot.current_position.direction).to eq("WEST")
        end
      end
      
      context 'with direction EAST' do
        let(:position) { Position.new({x: 1, y: 2, direction: 'EAST'}) }

        it 'after left direction will be change to NORTH' do
          robot.place(table, position)
          robot.left
          expect(robot.current_position.direction).to eq("NORTH")
        end
      end

      context 'with direction SOUTH' do
        let(:position) { Position.new({x: 1, y: 2, direction: 'SOUTH'}) }

        it 'after left direction will be change to EAST' do
          robot.place(table, position)
          robot.left
          expect(robot.current_position.direction).to eq("EAST")
        end
      end
      
      context 'with direction WEST' do
        let(:position) { Position.new({x: 1, y: 2, direction: 'WEST'}) }

        it 'after left direction will be change to SOUTH' do
          robot.place(table, position)
          robot.left
          expect(robot.current_position.direction).to eq("SOUTH")
        end
      end
    end
  end

  describe '#move' do
    context 'when robot not placed' do
      it 'will return alert message' do
        expect(robot.move(table)).to eq("Please place your robot first!")
      end
    end

    context 'when robot placed' do
      context 'when moves to NORTH' do
        let(:position) { Position.new({x: 1, y: 1, direction: 'NORTH'}) }

        it 'move the robot one unit forward to NORTH' do
          robot.place(table, position)
          robot.move(table)
          expect(robot.current_position.x).to eq(1)
          expect(robot.current_position.y).to eq(2)
          expect(robot.current_position.direction).to eq("NORTH")
        end
      end

      context 'when moves to EAST' do
        let(:position) { Position.new({x: 2, y: 2, direction: 'EAST'}) }

        it 'move the robot one unit forward to EAST' do
          robot.place(table, position)
          robot.move(table)
          expect(robot.current_position.x).to eq(3)
          expect(robot.current_position.y).to eq(2)
          expect(robot.current_position.direction).to eq("EAST")
        end
      end

      context 'when moves to SOUTH' do
        let(:position) { Position.new({x: 1, y: 1, direction: 'SOUTH'}) }

        it 'move the robot one unit forward to SOUTH' do
          robot.place(table, position)
          robot.move(table)
          expect(robot.current_position.x).to eq(1)
          expect(robot.current_position.y).to eq(0)
          expect(robot.current_position.direction).to eq("SOUTH")
        end
      end

      context 'when moves to WEST' do
        let(:position) { Position.new({x: 3, y: 1, direction: 'WEST'}) }

        it 'move the robot one unit forward to WEST' do
          robot.place(table, position)
          robot.move(table)
          expect(robot.current_position.x).to eq(2)
          expect(robot.current_position.y).to eq(1)
          expect(robot.current_position.direction).to eq("WEST")
        end
      end

      context 'when robot reaches to edge and try to moves to NORTH' do
        let(:position) { Position.new({x: 0, y: 4, direction: 'NORTH'}) }

        it 'robot will not move and return alert message' do
          robot.place(table, position)
          expect(robot.move(table)).to eq("Invalid coordinate!")
          expect(robot.current_position).to eq(position)
        end
      end
    end
  end

  describe '#report' do
    let(:position) { Position.new({x: 1, y: 2, direction: 'NORTH'}) }

    context 'when robot placed' do
      it 'return current position with direction' do
        robot.place(table, position)
        expect(robot.report).to eq('1,2,NORTH')
      end
    end

    context 'when robot placed' do
      it 'return alert message' do
        expect(robot.report).to eq('Robot not placed!')
      end
    end
  end
end
