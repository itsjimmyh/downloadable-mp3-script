require 'spec_helper'

describe RangeGenerator do

  let(:range_generator) { RangeGenerator.new }

  describe '#initialize' do
  end

  describe '#generate_combinations' do
    it 'generates the combinations possible from a start and end range with a provided gap' do
      expect(range_generator.generate_combinations(1, 3, 0).count).to eq 6
      expect(range_generator.generate_combinations(1, 3, 1).count).to eq 3
      expect(range_generator.generate_combinations(1, 4, 1).count).to eq 6
      expect(range_generator.generate_combinations(1, 59, 11).count).to eq 1176
      expect(range_generator.generate_combinations(1, 44, 11).count).to eq 561
    end

    it 'returns an array of arrays in the format of [[start_note, end_note]]' do
      expected = [[1, 1], [1, 2], [1, 3], [2, 2], [2, 3], [3, 3]]
      actual = range_generator.generate_combinations(1, 3, 0)

      expect(actual).to eq expected
    end
  end
end
