require './upload_script.rb'
require 'rspec'

describe '#generate_arr_of_all_combinations' do
  it 'generates all combinations of of a start and end range and respects gaps' do
    expect(generate_arr_of_all_combinations(1, 3, 0).count).to eq 6 
    expect(generate_arr_of_all_combinations(1, 3, 1).count).to eq 3
    expect(generate_arr_of_all_combinations(1, 4, 1).count).to eq 6
    expect(generate_arr_of_all_combinations(1, 59, 11).count).to eq 1176
  end
end


describe '#to_padded_time' do
  it 'converts seconds into padded time ie: 180.186 --> 00:03:00.186' do
    expect(to_padded_time(180.186)).to eq "00:03:00.186"
    expect(to_padded_time(3.188)).to eq "00:00:03.188"
  end
end


describe '#' do
end
