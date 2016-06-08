# require './ffmpeg.rb'
# require './exercise.rb'
# require './range_generator.rb'
#
# Chunk Clips Test

root_path = "/Users/itsjimmyh/Desktop/rf_sounds/"
dir1_path = root_path + "exercise_1"
ex_1_full_clip = dir1_path + "/exercise_1_final.mp3"


def chunk_split_clips(file, file_duration, start_cut, cut_duration, output_path)
  ffmpeg = FFmpeg.new
  ffmpeg.debug = true
  ffmpeg.should_run = true

  combinations = generate_combinations(1, 44, 11)  
  
  combinations.each do |combo|
    start_note, end_note = combo

    output_file_name = combo.join("_") + ".mp3"
    start_time = to_padded_time((start_note - 1) * cut_duration) 
    end_time = to_padded_time(end_note * cut_duration)

    ffmpeg.split(file, output_file_name, start_time, end_time, output_path)
  end
end



def to_padded_time(time_in_seconds)
  Time.at(time_in_seconds).utc.round(3).strftime("%H:%M:%S.%L")
end


def generate_combinations(start_range, end_range, gap)
  combinations = []

  start_range.upto(end_range - gap) do |x|
    x.upto(end_range) do |y|
      next if (x + gap) > y
      combinations.push([x, y])
    end
  end

  combinations
end

