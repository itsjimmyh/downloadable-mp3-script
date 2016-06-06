!#/usr/bin/evn ruby
require 'rubygems'
require 'aws-sdk'


region = 'us-west-2'

s3 = AWS::S3.new(region: region)

file_name = "/Users/itsjimmyh/Desktop/rf_sounds/full_exercise.mp3"
key = File.basename(file_name)


# this is the command to run
# s3.buckets[bucket_name].objects[key].write(file: file_name)
