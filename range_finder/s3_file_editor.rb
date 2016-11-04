require 'FileUtils'
require 'rubygems'
require 'aws-sdk'
require 'pry'

require './lib/range_generator.rb'

ROOT_PATH = "/Users/itsjimmyh/Desktop/rf_sounds/"
COMPLETED_MP3S_PATH = "completed_mp3s/download_mp3/"
AMAZON_USER_DEFINED_METADATA_PREFIX = 'x-amz-meta-'

LOW_NOTES = %w(
  stub0 A2 Bb2 B2 C3 Db3 D3 Eb3 E3 F3 Gb3 G3 Ab3 A3 Bb3 B3 C4 Db4 D4 Eb4 E4
  F4 Gb4 Ab4 A4 Bb4 B4 C5 Db5 D5 Eb5 E5 F5 Gb5
)
HIGH_NOTES = %w(
  stub0 stub1 stub2 stub3 stub4 stub5 stub6 stub7 stub8 stub9 stub10 stub11
  G#3 A3 A#3 B3 C4 C#4 D4 D#4 E4 F4 F#4 G4 G#4 A4 A#4 B4 C5 C#5 D5 D#5 E5 F5
  F#5 G5 G#5 A5 A#5 B5 C6 C#6 D6 D#6 E6
)

def vocal_warm_up_file_name(start_range, end_range)
  low_note = LOW_NOTES[start_range]
  high_note = HIGH_NOTES[end_range]

  "Vocal_Warm_Up_#{low_note}-#{high_note}.mp3"
end

def download_file_name(file_name)
  "attachment;filename=#{file_name}"
end


def local_file_path(start_range, end_range)
  "#{ROOT_PATH}#{COMPLETED_MP3S_PATH}#{start_range}/#{start_range}_#{end_range}.mp3"
end

range_generator = RangeGenerator.new
combinations = range_generator.generate_combinations(1, 44, 11)

file_names = []
combinations.each do |combo|
  start_range, end_range = combo
  file_names << local_file_path(start_range, end_range)
end

# S3 Settings
config = {
  :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
  :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
  :region => 'us-west-2',
}

bucket_name = ENV['AWS_STATIC_ASSETS_BUCKET']

s3 = AWS::S3.new(config)
bucket = s3.buckets[bucket_name]


# figure out how to upload to s3
# figure out how to iterate over a folder programmatically
# iterate over the folder containing all of the files
# update each key's meta name in the format of
# Key: Content-Disposition, Value: attachment;filename=Vocal_Warm_Up_A2-G#3.mp3

# after preparing all the files, 1_12, 1_13, run this loop to write to s3
# this will set the file to public read
# s3 filepath will remain the same as /download_mp3/1_12.mp3
# when files are downloaded,the content-disposition will dl them with the right names
file_names[0..0].each do |f_name|
  name = f_name.split('/').last
  start_range = name.split("_").first.to_i
  end_range = name.split("_").last.split(".").first.to_i

  # start_range, end_range = combinations[idx]

  write_path = "vocal_warm_ups/rm_assignment/#{start_range}/#{start_range}_#{end_range}.mp3"

  file_name = vocal_warm_up_file_name(start_range, end_range)
  content_disposition_value = download_file_name(file_name)
  content_type_value = "audio/mpeg"

  options = {
    file: f_name,
    content_disposition: content_disposition_value,
    content_type: content_type_value,
    acl: :public_read
  }

  bucket.objects["#{write_path}"].write(options)
  puts "wrote #{f_name} to #{write_path}"
end
