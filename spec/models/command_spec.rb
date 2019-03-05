require 'rails_helper'

RSpec.describe Command, type: :model do

  let(:robot) { Robot.new }
  let(:table) { Table.new({length: 5, width: 5}) }
  let(:command) { Command.new({robot: robot, table: table}) }

  describe '#execute' do
    context 'when command is PLACE' do
      let(:position) { Position.new({x: 1, y: 1, direction: 'NORTH'}) }

      it 'invoke Robot#place method with arguments' do
        allow(Position).to receive(:new).with({x: 1, y: 1, direction: 'NORTH'}).and_return(position)
        allow_any_instance_of(Robot).to receive(:place).with(table, position).and_return({x: 1, y: 1, direction: 'NORTH'})
        command.execute('PLACE 1,1,NORTH')
      end

      it 'will return position passed with place command' do
        expect(command.execute('PLACE 1,1,NORTH').as_json).to eq(position.as_json)
      end
    end

    context 'when command is MOVE' do
      let(:position) { Position.new({x: 1, y: 1, direction: 'NORTH'}) }

      it 'invoke Robot#move method with argument' do
        command.execute('PLACE 1,1,NORTH')
        allow_any_instance_of(Robot).to receive(:move).with(table).and_return({x: 1, y: 1, direction: 'NORTH'})
        command.execute('MOVE')
      end

      it 'will return updated position' do
        command.execute('PLACE 1,1,NORTH') 
        expect(command.execute('MOVE').as_json).to eq({"x"=>1, "y"=>2, "direction"=>"NORTH"})
      end
    end

    context 'when command is LEFT' do
      let(:position) { Position.new({x: 1, y: 1, direction: 'NORTH'}) }

      it 'invoke Robot#left method with argument' do
        command.execute('PLACE 1,1,NORTH')
        allow_any_instance_of(Robot).to receive(:left)
        command.execute('LEFT')
      end

      it 'will return updated direction with position' do
        command.execute('PLACE 1,1,NORTH') 
        expect(command.execute('LEFT').as_json).to eq({"x"=>1, "y"=>1, "direction"=>"WEST"})
      end
    end

    context 'when command is RIGHT' do
      let(:position) { Position.new({x: 1, y: 1, direction: 'NORTH'}) }

      it 'invoke Robot#right method with argument' do
        command.execute('PLACE 1,1,NORTH')
        allow_any_instance_of(Robot).to receive(:right)
        command.execute('RIGHT')
      end

      it 'will return updated direction with position' do
        command.execute('PLACE 1,1,NORTH') 
        expect(command.execute('RIGHT').as_json).to eq({"x"=>1, "y"=>1, "direction"=>"EAST"})
      end
    end

    context 'when command is REPORT' do
      let(:position) { Position.new({x: 1, y: 1, direction: 'NORTH'}) }

      it 'invoke Robot#report method with argument' do
        command.execute('PLACE 1,1,NORTH')
        allow_any_instance_of(Robot).to receive(:report)
        command.execute('REPORT')
      end

      it 'will return position as a comma seperated string' do
        command.execute('PLACE 1,1,NORTH') 
        expect(command.execute('REPORT').as_json).to eq("1,1,NORTH")
      end
    end

    context 'when invalid command pass' do
      it 'will return Invalid command! message' do
        expect(command.execute("invalid command")).to eq("Invalid command!")
      end
    end
  end
end