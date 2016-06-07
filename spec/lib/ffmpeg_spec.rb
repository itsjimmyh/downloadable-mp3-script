require 'spec_helper'
require 'FileUtils'

describe FFmpeg do
  
  let(:ffmpeg) { FFmpeg.new }
  let(:start_time) { '00:00:00.000' }
  let(:end_time)   { '00:00:03.000' }

  describe '#initialize' do
    it 'should set ffmpeg' do
      expect(ffmpeg.ffmpeg).to match(/ffmpeg/)
    end
  end

  describe '#split' do
    let(:mp3)           { Tempfile.new('mp3').path }
    let(:mp3_file)      { './sample_data/sample.mp3' }
    let(:output_name)   { "#{ (Time.now).to_i }output.mp3" }
    let(:output_path)   { '/tmp' }
    let(:output_file)   { File.join(output_path, output_name) }
    let(:command)       { "#{ ffmpeg.ffmpeg } -i #{ mp3_file } -ss #{ start_time } -t #{ end_time } -acodec copy #{ output_file }" }

    after(:each) do
      FileUtils.rm(output_file) if File.exists?(output_file)
    end

    it 'takes in a file, and creates an output file' do 
      ffmpeg.should_run = true
      ffmpeg.debug = true

      expect{ 
        ffmpeg.split(mp3_file, output_name, start_time, end_time, output_path) 
      }.to change{ 
        File.exists?(output_file)
      }

    end

    it 'calls ffmpeg with necessary arguments' do
      ffmpeg.should_run = true
      expect(ffmpeg).to receive(:run).with(command)

      ffmpeg.split(mp3_file, output_name, start_time, end_time, output_path)
    end
  end

  
  describe '#merge' do
    let(:mp3_1)          { Tempfile.new('mp3_1').path }
    let(:mp3_2)          { Tempfile.new('mp3_2').path }
    let(:files_to_merge) { [mp3_1, mp3_2] }


    it 'takes audio files and merges them together' do
      ffmpeg.should_run = true

      binding.pry
      expect{
        ffmpeg.merge(files_to_merge, output_file_name, output_path)
      }.to change{
        File.exists?(output_file)
      }
      
    end
  end
end

