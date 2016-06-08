require 'spec_helper'

describe Exercise do

  describe '#initialize' do
    let(:options_hash) { {
                            start_offset: -1,
                            end_offset: -1,
                            single_clip_duration: 5,
                            full_clip_length: 100,
                            root_directory_path: "/tmp",
                            full_mp3_path: "/tmp/full_mp3.mp3"
                          }
                        }

    describe 'should accept an options hash' do
      let(:exercise) { Exercise.new(options_hash) }
      it 'should set @start_offset = hash[:start_offset]' do
        expect(exercise.start_offset).to eq options_hash[:start_offset]
      end

      it 'should set @end_offset = hash[:end_offset]' do
        expect(exercise.end_offset).to eq options_hash[:end_offset]
      end

      it 'should set @single_clip_duration = hash[:single_clip_duration]' do
        expect(exercise.single_clip_duration).to eq options_hash[:single_clip_duration]
      end

      it 'should set @full_clip_length = hash[:full_clip_length]' do
        expect(exercise.full_clip_length).to eq options_hash[:full_clip_length]
      end

      it 'should set @root_directory_path = hash[:root_directory_path]' do
        expect(exercise.root_directory_path).to eq options_hash[:root_directory_path]
      end

      it 'should set @full_mp3_path = hash[:full_mp3_path]' do
        expect(exercise.full_mp3_path).to eq options_hash[:full_mp3_path]
      end

    end
  end
end
