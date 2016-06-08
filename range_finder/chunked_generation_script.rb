require './lib/ffmpeg.rb'
require './lib/exercise.rb'
require './lib/range_generator.rb'
# Generate Chunked Clips (ribbon cutting)

root_path = "/Users/itsjimmyh/Desktop/rf_sounds/"

ex1_path = root_path + "exercise_1/"
ex2_path = root_path + "exercise_2/"
ex3_path = root_path + "exercise_3/"
ex4_path = root_path + "exercise_4/"
ex5_path = root_path + "exercise_5/"
ex6_path = root_path + "exercise_6/"

ex1_full_mp3 = ex2_path + "exercise_1_final.mp3"
ex2_full_mp3 = ex2_path + "exercise_2_final.mp3"
ex3_full_mp3 = ex3_path + "exercise_3_final.mp3"
ex4_full_mp3 = ex4_path + "exercise_4_final.mp3"
ex5_full_mp3 = ex5_path + "exercise_5_final.mp3"
ex6_full_mp3 = ex6_path + "exercise_6_final.mp3"

def hash_gen(start_offset, end_offset, single_clip_duration, full_clip_length, root_dir_path, full_mp3_path)
  { 
    start_offset: start_offset,
    end_offset: end_offset,
    single_clip_duration: single_clip_duration,
    full_clip_length: full_clip_length,
    root_directory_path: root_dir_path,
    full_mp3_path: full_mp3_path
  }
end

ex1_options = hash_gen(-3, -3, 3.5, 154, ex1_path, ex1_full_mp3)
ex2_options = hash_gen(-3, -3, 4, 176, ex2_path, ex2_full_mp3)
ex3_options = hash_gen(-3, -3, 4, 176, ex3_path, ex3_full_mp3)
ex4_options = hash_gen(-3, -9, 4, 176, ex4_path, ex4_full_mp3)
ex5_options = hash_gen(-3, -9, 3, 132, ex5_path, ex5_full_mp3)
ex6_options = hash_gen(-3, -15, 7, 308, ex6_path, ex6_full_mp3)


ex1 = Exercise.new(ex1_options)
ex2 = Exercise.new(ex2_options)
ex3 = Exercise.new(ex3_options)
ex4 = Exercise.new(ex4_options)
ex5 = Exercise.new(ex5_options)
ex6 = Exercise.new(ex6_options)

range_generator = RangeGenerator.new



def to_padded_time(time_in_seconds)
  Time.at(time_in_seconds).utc.round(3).strftime("%H:%M:%S.%L")
end

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



def test(item)
  binding.pry
end

test(ex1)
