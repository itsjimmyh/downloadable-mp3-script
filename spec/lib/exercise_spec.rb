require 'spec_helper'

describe Exercise do

  describe '#initialize' do
    let(:generator)    { RangeGenerator.new }
    let(:options_hash) { {
                            start_offset: -1,
                            end_offset: -1,
                            single_clip_duration: 5,
                            full_clip_length: 100,
                            root_directory_path: "/tmp",
                            full_mp3_path: "/tmp/full_mp3.mp3",
                            generator: generator,
                            clip_start_number: 1,
                            clip_end_number: 44,
                            gap: 11
                          }
                        }


    describe '#initialize should accept an options hash' do
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

      it 'should initialize with a generator' do
        expect(exercise.generator).to eq generator
      end

      it 'should set clip_start_number' do
        expect(exercise.clip_start_number).to eq options_hash[:clip_start_number]
      end

      it 'should set clip_end_number' do
        expect(exercise.clip_end_number).to eq options_hash[:clip_end_number]
      end

      it 'should set a gap' do
        expect(exercise.gap).to eq options_hash[:gap]
      end
    end

    describe '#generate_combinations' do
      let(:exercise) { Exercise.new(options_hash) }

      describe 'should use the generator to generate combinations' do
        it '@clip_start_number=1, @clip_end_number=44, @gap=11 should have 561 combinations' do
          expect(exercise.generate_combinations.count).to eq 561
        end

        it '@clip_start_number=1, @clip_end_number=2, @gap=0 should have 3 combinations' do
          exercise.clip_start_number = 1
          exercise.clip_end_number = 2
          exercise.gap = 0

          expect(exercise.generate_combinations.count).to eq 3
        end


        it '@clip_start_number=1, @clip_end_number=3, @gap=0 should have 6 combinations' do
          exercise.clip_start_number = 1
          exercise.clip_end_number = 3
          exercise.gap = 0

          expect(exercise.generate_combinations.count).to eq 6
        end
      end
    end
  end
end
