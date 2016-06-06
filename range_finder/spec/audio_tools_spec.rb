require './audio_tools.rb'
require 'rspec'

describe "module Audio" do

  describe "Audio.ffmpeg_merge" do
    
  end

  describe "Audio::Helpers" do

    describe "Audio::Helpers.to_padded_time" do
      it 'turns seconds into padded time' do
        expect(Audio::Helpers.to_padded_time(120)).to eq "00:02:00.000"
        expect(Audio::Helpers.to_padded_time(180.186)).to eq "00:03:00.186"
        expect(Audio::Helpers.to_padded_time(300.185)).to eq "00:05:00.185"
        expect(Audio::Helpers.to_padded_time(300.186)).to eq "00:05:00.186"
      end
    end

  end
end
