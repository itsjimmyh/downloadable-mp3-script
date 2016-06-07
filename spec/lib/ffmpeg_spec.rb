require 'spec_helper'
require 'FileUtils'

describe FFmpeg do
  
  let(:ffmpeg) { FFmpeg.new }

  describe '#initialize' do
    it 'should set ffmpeg' do
      expect(ffmpeg.ffmpeg).to match(/ffmpeg/)
    end
  end

  describe '#split' do
    let(:mp3) { Tempfile.new('mp3').path }
    let(:mp3_file) { './sample_data/sample.mp3' }
    let(:output_name) { "#{ (Time.now).to_i }output.mp3" }
    let(:start_time) { '00:00:00.000' }
    let(:end_time)   { '00:00:03.000' }
    let(:output_path) { '/tmp' }
    let(:output_file) { File.join(output_path, output_name) }
    let(:command) { "#{ ffmpeg.ffmpeg } -i #{ mp3_file } -ss #{ start_time } -t #{ end_time } -acodec copy #{ output_file }" }

    after(:each) do
      FileUtils.rm(output_file) if File.exists?(output_file)
    end

    it 'takes in a file, and creates an output file' do 
      ffmpeg.should_run = true
      ffmpeg.debug = true

      expect{ ffmpeg.split(mp3_file, output_name, start_time, end_time, output_path) }.to change{ File.exists?(output_file) }
    end

    it 'calls ffmpeg with necessary arguments' do
      ffmpeg.should_run = true
      expect(ffmpeg).to receive(:run).with(command)

      ffmpeg.split(mp3_file, output_name, start_time, end_time, output_path)
    end

  end
end

