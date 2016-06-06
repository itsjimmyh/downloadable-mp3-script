## ffmpeg tools
# ffmpeg
def ffmpeg
  `which ffmpeg`.chomp
end


# Split file
# ffmpeg_split(input_file, output_file, "00:00:01.53", "00:00:02.59")
def ffmpeg_split(input, output_name, start_time, end_time, run_flag=false, output_path="/Users/itsjimmyh/Desktop/rf_sounds/")
   view_command = "ffmpeg -i #{ input } -ss #{ start_time } -t #{ end_time } -acodec copy #{ output_path }#{ output_name }"
  
  if run_flag
    `#{ view_command }` 
  else
    p view_command
  end

  p output_path + output_name
end


# Merge Files
# provide an array of files for ffmpeg to merge
# provide an output name for ffmpeg to name the file
# decide whether you wish to see the commands or run them via passing a true || false flag
# provide output_path for where you want your merged file to be placed
# ffmpeg_merge(["1.mp3, 2.mp3, 3.mp3"], "exercise_1.mp3")
def ffmpeg_merge(files, output_file_name, run_flag=false, output_path="/Users/itsjimmyh/Desktop/rf_sounds/")
  files_to_merge = files.join("|")

  command = "ffmpeg -i 'concat:#{ files_to_merge}' -acodec copy #{ output_path }#{ output_file_name }.mp3"

  if run_flag
    p "in #ffmpeg_merge"
    `#{ command }`
  else
    p command
  end

  output_path + output_file_name + ".mp3"
end




## Helper to split long mp3 by a cut length
  # run command
# split_clips("/Users/itsjimmyh/Desktop/rf_sounds/new_exercise.mp3", 3.5, 0, 196, 1, true)
  # to show what commands are being run 
# split_clips("/Users/itsjimmyh/Desktop/rf_sounds/full_exercise.mp3", 3.094, 0, 180)
def split_clips(file, cut_length, start_time, end_time, rounding=3, run_flag=false)
  start_time = start_time
  cut_end = 0
  
  clip_name = 1
  
  until start_time > end_time
    ffmpeg_split(file, "#{clip_name}.mp3", to_padded_time(start_time), cut_length, run_flag)

    start_time = (start_time + cut_length).round(rounding)
    clip_name += 1
  end

  true
end


## 180.186 --> "00:03:00.186"
def to_padded_time(time_in_seconds)
  Time.at(time_in_seconds).utc.strftime("%H:%M:%S.%L")
end

## Helpers for generate_downloadable_mp3

# generate_downloadable_mp3_list("/Users/itsjimmyh/Desktop/rf_sounds/", 1, 11)
def generate_downloadable_mp3_list(root_path, x, y)
  p "in #generate_downloadable_mp3_list"
  ga_intro = root_path + "GLOBAL_INTRO.mp3"
  ga_closing = root_path + "GLOBAL_CLOSING.mp3"

  dir1_path = root_path + "exercise_1/"
  ex_1_intro = dir1_path + "ca_exercise_1.mp3"
  
  dir2_path = root_path + "exercise_2/"
  ex_2_intro = dir2_path + "ca_exercise_2.mp3"

  dir3_path = root_path + "exercise_3/"
  ex_3_intro = dir3_path + "ca_exercise_3.mp3"

  dir4_path = root_path + "exercise_4/"
  ex_4_intro = dir4_path + "ca_exercise_4.mp3"

  dir5_path = root_path + "exercise_5/"
  ex_5_intro = dir5_path + "ca_exercise_5.mp3"

  dir6_path = root_path + "exercise_6/"
  ex_6_intro = dir6_path + "ca_exercise_6.mp3"

  files_to_merge = [].push(ga_intro)
 
  range = *(x..y)

  dir1_files = [].push(ex_1_intro)
  dir2_files = [].push(ex_2_intro)
  dir3_files = [].push(ex_3_intro)
  dir4_files = [].push(ex_4_intro)
  dir5_files = [].push(ex_5_intro)
  dir6_files = [].push(ex_6_intro)

  range.each do |number|
    dir1_files << dir1_path + "#{number}.mp3"
    dir2_files << dir2_path + "#{number}.mp3"
    dir3_files << dir3_path + "#{number}.mp3"
    dir4_files << dir4_path + "#{number}.mp3"
    dir5_files << dir5_path + "#{number}.mp3"
    dir6_files << dir6_path + "#{number}.mp3"
  end

  files_to_merge
    .concat(dir1_files)
    .concat(dir2_files)
    .concat(dir3_files)
    .concat(dir4_files)
    .concat(dir5_files)
    .concat(dir6_files)
    .concat([ga_closing])
end


