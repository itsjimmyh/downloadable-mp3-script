require 'spec_helper'

describe Exercise do

  describe '#initialize' do
    let(:options_hash) { {
                            start_offset: -1,
                            end_offset: -1,
                            clip_duration: 5,
                            root_directory_path: "/tmp"
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

      it 'should set @clip_duration = hash[:clip_duration]' do
        expect(exercise.clip_duration).to eq options_hash[:clip_duration]
      end

      it 'should set @root_directory_path = hash[:root_directory_path]' do
        expect(exercise.root_directory_path).to eq options_hash[:root_directory_path]
      end
    end
  end
end
