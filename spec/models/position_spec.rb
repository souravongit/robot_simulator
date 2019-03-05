require 'rails_helper'

RSpec.describe Position, type: :model do
  describe '#move_towards' do
    let(:position) { Position.new({x: 2, y: 2, direction: 'NORTH'}) }
    
    context "when direction is NORTH" do
      it 'will go one unit forword to NORTH' do
        expect(position.move_towards('NORTH').as_json).to eq({"x"=>2, "y"=>3, "direction"=>"NORTH"})
      end
    end

    context "when direction is EAST" do
      it 'will go one unit forword to EAST' do
        position.direction = 'EAST'
        expect(position.move_towards('EAST').as_json).to eq({"x"=>3, "y"=>2, "direction"=>"EAST"})
      end
    end

    context "when direction is WEST" do
      it 'will go one unit forword to WEST' do
        position.direction = 'WEST'
        expect(position.move_towards('WEST').as_json).to eq({"x"=>1, "y"=>2, "direction"=>"WEST"})
      end
    end

    context "when direction is SOUTH" do
      it 'will go one unit forword to SOUTH' do
        position.direction = 'SOUTH'
        expect(position.move_towards('SOUTH').as_json).to eq({"x"=>2, "y"=>1, "direction"=>"SOUTH"})
      end
    end
  end

  describe '#direction_left' do
    let(:position) { Position.new({x: 2, y: 2, direction: 'NORTH'}) }

    it 'will return WEST when robot is facing NORTH' do
      expect(position.direction_left).to eq('WEST')
    end

    it 'will return  NORTH when robot is facing EAST' do
      position.direction = 'EAST'
      expect(position.direction_left).to eq('NORTH')
    end

    it 'will return EAST when robot is facing SOUTH' do
      position.direction = 'SOUTH'
      expect(position.direction_left).to eq('EAST')
    end

    it 'will return SOUTH when robot is facing WEST' do
      position.direction = 'WEST'
      expect(position.direction_left).to eq('SOUTH')
    end
  end

  describe '#direction_right' do
    let(:position) { Position.new({x: 2, y: 2, direction: 'NORTH'}) }
    
    it 'will return EAST when robot is facing NORTH' do
      expect(position.direction_right).to eq('EAST')
    end

    it 'will return SOUTH when robot is facing EAST' do
      position.direction = 'EAST'
      expect(position.direction_right).to eq('SOUTH')
    end

    it 'will return WEST when robot is facing SOUTH' do
      position.direction = 'SOUTH'
      expect(position.direction_right).to eq('WEST')
    end

    it 'will return NORTH when robot is facing WEST' do
      position.direction = 'WEST'
      expect(position.direction_right).to eq('NORTH')
    end
  end
end