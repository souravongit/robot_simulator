require 'rails_helper'

RSpec.describe Table, type: :model do

  describe '#is_valid_position?' do
    let(:table) { Table.new({length: 5, width: 5}) }

    context "when coordinates are valid" do
      let(:position) { Position.new({x: 2, y: 3, direction: 'NORTH'}) }

      it 'should return true as a response' do
        expect(table.is_valid_position?(position)).to be true
      end
    end

    context "when coordinates are invalid" do
      let(:position1) { Position.new({x: 6, y: 6, direction: 'EAST'}) }
      let(:position2) { Position.new({x: 2, y: 6, direction: 'WEST'}) }
      let(:position3) { Position.new({x: 6, y: 2, direction: 'NORTH'}) }

      it 'should return false as a response' do
        expect(table.is_valid_position?(position1)).to be false
        expect(table.is_valid_position?(position2)).to be false
        expect(table.is_valid_position?(position3)).to be false
      end
    end    

    context "when coordinates are negative" do
      let(:position) { Position.new({x: -1, y: -2, direction: 'SOUTH'}) }

      it 'should return false as a response' do
        expect(table.is_valid_position?(position)).to be false
      end
    end
  end
end