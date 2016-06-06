require 'rubygems'
require 'id3lib'
require 'FileUtils'

# ffmpeg = `/usr/local/bin/ffmpeg`
# path_to_piano_mp3s = `/Users/itsjimmyh/Desktop/pianosounds_mp3`

# source ffmpeg && run command
def ffmpeg(command)
  ffmpeg_path = `which ffmpeg`.chomp
  `#{ ffmpeg_path } #{ command }`
end


# merge mp3's with mp3warp
# mp3wrap_merge('path/to/directory/mp3_name.mp3', 'output_file_name', '/Users/itsjimmyh/Desktop/pianosounds_mp3/')
def mp3wrap_merge(mp3s, output_file_name, path)
  mp3wrap_path = `which mp3wrap`.chomp

  `#{ mp3wrap_path } #{ path }#{ output_file_name } #{ mp3s }`
end


# pass a file to use ffmpeg to convert it to mp3 format
def convert_to_mp3(file, file_dir)
  return if file_dir.include?(file)

  binding.pry
  file_name = file.split('.').first
  command = "-i #{ file } -acodec libmp3lame #{ file_name }.mp3"

  ffmpeg(command)
end


# '/Users/itsjimmyh/Desktop/pianosounds_mp3'
# apply_to_dir('/Users/itsjimmyh/Desktop/pianosounds_mp3')
# deprecated, see #iterate_over_path(path)
def apply_to_dir(path_to_directory)
  files = Dir.open(path_to_directory) 
  
  files.each do |file|
    next if file[0] == '.'
    convert_to_mp3(construct_file_path(file), files)
  end

  # remove the files from directory
  # files.each do |file|
  #   if file.include?(".wav")
  #     FileUtils.rm(construct_file_path(file))
  #   end
  # end
  true
end


# construct file path
def construct_file_path(path="/Users/itsjimmyh/Desktop/pianosounds_mp3/", file)
  path.concat("#{ file }")
end


# generate command to merge files in order
def command_to_merge_files(tool, input)
  p "#{ tool } #{ input }"
end

# generate_file_names(*(1..61), ".mp3"))
def generate_file_names(range, file_suffix)
  results = []

  range.each do |file_name|
    results << "#{ file_name }#{ file_suffix }"
  end

  results.join(' ')
end


## Clip Slicing
# generate command to slice clips to a specific length
def generate_trim_clip_command(path, file_name, file_modifier, duration=3)
  `ffmpeg -t #{ duration } -i #{ path }#{ file_name } -acodec copy #{ path }#{ file_modifier }#{ file_name }`
end


# iterate over files in a path and apply your block to it
# use via:
#   iterate_over_path("path/to/directory/") { |path_to_file| your_block_here(path_to_file) } 
def iterate_over_path(path)
  files = Dir.open(path)

  files.each do |file|
    next if file[0] == '.'

    if block_given?
      yield(file)
    else
      p "no block given"
    end
  end

  true
end

# iterate_over_path(path) do |file|
#   generate_trim_clip_command(file, file_modifier, duration=3)
# end

# iterate_over_path("/Users/itsjimmyh/Desktop/pianosounds_mp3/", generate_trim_clip_command("#{ file }", "output_"))

# iterate_over_path("/Users/itsjimmyh/Desktop/pianosounds_mp3") { |file| generate_trim_clip_command("/Users/itsjimmyh/Desktop/pianosounds_mp3/", file, "output_") }
#
