require 'spec_helper'
require 'FileUtils'

describe FFmpeg do
  
  let(:ffmpeg) { FFmpeg.new }

  describe '#initialize' do
    it 'should set ffmpeg' do
      expect(ffmpeg.ffmpeg).to match(/ffmpeg/)
    end

    it 'defaults @should_run to false' do
      expect(FFmpeg.new.should_run).to eq false
    end

    it 'defaults @debug to false' do
      expect(FFmpeg.new.debug).to eq false
    end
  end

  describe '#split' do
    let(:mp3)           { Tempfile.new('mp3').path }
    let(:start_time)    { '00:00:00.000' }
    let(:end_time)      { '00:00:03.000' }
    let(:mp3_file)      { './sample_data/sample.mp3' }
    let(:output_name)   { "#{ (Time.now).to_i }output.mp3" }
    let(:output_path)   { '/tmp' }
    let(:output_file)   { File.join(output_path, output_name) }
    let(:command)       { "#{ ffmpeg.ffmpeg } -i #{ mp3_file } -ss #{ start_time } -t #{ end_time } -acodec copy #{ output_file }" }

    before(:each) do
      ffmpeg.should_run = true
      ffmpeg.debug = true
    end

    after(:each) do
      FileUtils.rm(output_file) if File.exists?(output_file)
    end

    it 'takes in a file, and creates an output file' do 
      expect{ 
        ffmpeg.split(mp3_file, output_name, start_time, end_time, output_path) 
      }.to change{ 
        File.exists?(output_file)
      }

    end

    it 'calls ffmpeg with necessary arguments' do
      expect(ffmpeg).to receive(:run).with(command)

      ffmpeg.split(mp3_file, output_name, start_time, end_time, output_path)
    end
  end

  
  describe '#merge' do
    let(:mp3_1)               { './sample_data/1.mp3' }
    let(:mp3_2)               { './sample_data/2.mp3' }
    let(:files_to_merge)      { [mp3_1, mp3_2] }
    let(:output_path)         { '/tmp' }
    let(:output_name)         { "#{ (Time.now).to_i }merged_output.mp3" }
    let(:output_file_dir)     { File.join(output_path, output_name) }
    let(:command)             { "#{ ffmpeg.ffmpeg } -i 'concat:#{ files_to_merge.join("|") }' -acodec copy #{ output_file_dir }" }

    before(:each) do
      ffmpeg.should_run = true
      ffmpeg.debug = true
    end

    after(:each) do
      #FileUtils.rm(output_file) if File.exists?(output_file)
    end

    it 'takes audio files and merges them together' do
      expect{
        ffmpeg.merge(files_to_merge, output_path, output_name)
      }.to change{
        File.exists?(output_file_dir)
      }
    end

    it 'calls ffmpeg with necessary arguments' do
      expect(ffmpeg).to receive(:run).with(command)

      ffmpeg.merge(files_to_merge, output_path, output_name)
    end

  end
end

