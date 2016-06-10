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

ex1_full_mp3 = ex1_path + "exercise_1_final.mp3"
ex2_full_mp3 = ex2_path + "exercise_2_final.mp3"
ex3_full_mp3 = ex3_path + "exercise_3_final.mp3"
ex4_full_mp3 = ex4_path + "exercise_4_final.mp3"
ex5_full_mp3 = ex5_path + "exercise_5_final.mp3"
ex6_full_mp3 = ex6_path + "exercise_6_final.mp3"

chunk_clips_folder = "chunk_clips/"

ex1_chunk_clips_output_path = ex1_path + chunk_clips_folder
ex2_chunk_clips_output_path = ex2_path + chunk_clips_folder
ex3_chunk_clips_output_path = ex3_path + chunk_clips_folder
ex4_chunk_clips_output_path = ex4_path + chunk_clips_folder
ex5_chunk_clips_output_path = ex5_path + chunk_clips_folder
ex6_chunk_clips_output_path = ex6_path + chunk_clips_folder

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

def chunk_split_clips(mp3, output_path)
  ffmpeg = FFmpeg.new(true, true)
  file = mp3.full_mp3_path
  range_generator = RangeGenerator.new

  combinations = range_generator.generate_combinations(1, 44, 11)  
  
  combinations.each do |combo|
    start_note, end_note = combo

    output_file_name = combo.join("_") + ".mp3"
    start_eqn = ((start_note - 1) + (mp3.start_offset)) * mp3.single_clip_duration
    end_eqn = (end_note + (mp3.end_offset)) * mp3.single_clip_duration

    if start_eqn.abs > 0
      start_eqn = 0
    end

    if end_eqn < 0
      end_eqn = 0
    end

    start_time = to_padded_time(start_eqn)
    end_time = to_padded_time(end_eqn)

    ffmpeg.split(file, output_file_name, start_time, end_time, output_path)
  end
end


def chunk_split_reversed_clips(mp3, output_path)
  ffmpeg = FFmpeg.new(true, true)
  file = mp3.full_mp3_path
  range_generator = RangeGenerator.new

  combinations = range_generator.generate_combinations(1, 44, 11)

  combinations.each do |combo|
    start_note, end_note = combo

    output_file_name = combo.join("_") + ".mp3"
    start_eqn = (mp3.full_clip_length) - ( (end_note + (mp3.end_offset)) * mp3.single_clip_duration)
    end_eqn = (mp3.full_clip_length) - ( ((start_note - 1) + (mp3.start_offset)) * mp3.single_clip_duration)
   
    if end_eqn.abs > mp3.full_clip_length
      end_eqn = mp3.full_clip_length
    end

    start_time = to_padded_time(start_eqn)
    end_time = to_padded_time(end_eqn)

    ffmpeg.split(file, output_file_name, start_time, end_time, output_path)
  end
end


## Generate all combination of clips into folder structure

## Reversed Clips (ex 1 & 5)
## generate ribbon splitting of exercise 1, all combinations with offsets of 1-44
# chunk_split_reversed_clips(ex1, ex1_chunk_clips_output_path) 
## generate ribbon splitting of exercise 5
# chunk_split_reversed_clips(ex5, ex5_chunk_clips_output_path)

## Normal (unreversed clips: exercise: 2, 3, 4, 6)
## ribbon split exercise 2
# chunk_split_clips(ex2, ex2_chunk_clips_output_path)
## ribbon split exercise 3
# chunk_split_clips(ex3, ex3_chunk_clips_output_path)
## ribbon split exercise 4
# chunk_split_clips(ex4, ex4_chunk_clips_output_path)
## ribbon split exercise 6
# chunk_split_clips(ex6, ex6_chunk_clips_output_path)

## Merge clips together

ffmpeg = FFmpeg.new(true, true)
ga_intro = root_path + "GLOBAL_INTRO.mp3"
ga_closing = root_path + "GLOBAL_CLOSING.mp3"
ex1_intro = ex1_path + "ca_exercise_1.mp3"
ex2_intro = ex2_path + "ca_exercise_2.mp3"
ex3_intro = ex3_path + "ca_exercise_3.mp3"
ex4_intro = ex4_path + "ca_exercise_4.mp3"
ex5_intro = ex5_path + "ca_exercise_5.mp3"
ex6_intro = ex6_path + "ca_exercise_6.mp3"

ex1_1_12 = ex1_chunk_clips_output_path + "1_12.mp3"
ex2_1_12 = ex2_chunk_clips_output_path + "1_12.mp3"
ex3_1_12 = ex3_chunk_clips_output_path + "1_12.mp3"
ex4_1_12 = ex4_chunk_clips_output_path + "1_12.mp3"
ex5_1_12 = ex5_chunk_clips_output_path + "1_12.mp3"
ex6_1_12 = ex6_chunk_clips_output_path + "1_12.mp3"

clips_to_merge = [
  ga_intro,
  ex1_intro,
  ex1_1_12,
  ex2_intro,
  ex2_1_12,
  ex3_intro,
  ex3_1_12,
  ex4_intro,
  ex4_1_12,
  ex5_intro,
  ex5_1_12,
  ex6_intro,
  ex6_1_12,
  ga_closing
] 

def generate_path_name(path, combo)
  path + combo.join("_") + ".mp3"
end

# Merge all combinations
def generate_complete_clips(combinations, files={})
  
  ffmpeg = FFmpeg.new(true, true)

  combinations.each do |combo|
    files_to_merge = []
    start_range, end_range = combo

    files_to_merge.push(files[:ga_intro])

    ex1_intro = files[:ex1_intro]
    ex1 = generate_path_name(files[:ex1_path], combo) 

    ex2_intro = files[:ex2_intro]
    ex2 = generate_path_name(files[:ex2_path], combo)

    ex3_intro = files[:ex3_intro]
    ex3 = generate_path_name(files[:ex3_path], combo)

    ex4_intro = files[:ex4_intro]
    ex4 = generate_path_name(files[:ex4_path], combo)

    ex5_intro = files[:ex5_intro]
    ex5 = generate_path_name(files[:ex5_path], combo)

    ex6_intro = files[:ex6_intro]
    ex6 = generate_path_name(files[:ex6_path], combo)

    output_path = files[:output_path]
    output_name = combo.join("_") + ".mp3"

    files_to_merge
      .push(ex1_intro)
      .push(ex1)
      .push(ex2_intro)
      .push(ex2)
      .push(ex3_intro)
      .push(ex3)
      .push(ex4_intro)
      .push(ex4)
      .push(ex5_intro)
      .push(ex5)

      if start_range < 5 && end_range < 16
        files_to_merge.push(files[:ga_closing])
        ffmpeg.merge(files_to_merge, output_path, output_name)
      else
        files_to_merge
          .push(files[:ex6_intro])
          .push(ex6)
          .push(files[:ga_closing])
        ffmpeg.merge(files_to_merge, output_path, output_name) 
      end
  end
end

files = {
  ga_intro: ga_intro,
  ga_closing: ga_closing,
  ex1_intro: ex1_intro,
  ex2_intro: ex2_intro,
  ex3_intro: ex3_intro,
  ex4_intro: ex4_intro,
  ex5_intro: ex5_intro,
  ex6_intro: ex6_intro,
  ex1_path: ex1_chunk_clips_output_path,
  ex2_path: ex2_chunk_clips_output_path,
  ex3_path: ex3_chunk_clips_output_path,
  ex4_path: ex4_chunk_clips_output_path,
  ex5_path: ex5_chunk_clips_output_path,
  ex6_path: ex6_chunk_clips_output_path,
  output_path: root_path + "full_merged_exercises/"
}

combinations = range_generator.generate_combinations(1, 44, 11)

# this will stitch together all the combinations
# replace GA_INTRO, GA_CLOSING, and get finalized Example Q's
generate_complete_clips(combinations, files)

