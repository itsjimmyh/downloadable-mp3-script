require 'FileUtils'
require './lib/ffmpeg.rb'
require './lib/exercise.rb'
require './lib/reversed_exercise.rb'
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

## Inputs
# first round of offsets
# ex1_options = hash_gen(-3, -3, 3.5, 154, ex1_path, ex1_full_mp3)
# ex2_options = hash_gen(-3, -3, 4, 176, ex2_path, ex2_full_mp3)
# ex3_options = hash_gen(-3, -3, 4, 176, ex3_path, ex3_full_mp3)
# ex4_options = hash_gen(-3, -9, 4, 176, ex4_path, ex4_full_mp3)
# ex5_options = hash_gen(-3, -9, 3, 132, ex5_path, ex5_full_mp3)
# ex6_options = hash_gen(-3, -15, 7, 308, ex6_path, ex6_full_mp3)

# second round of new offsets
# ex1_options = hash_gen(0, -13, 3.5, 154, ex1_path, ex1_full_mp3)
# ex2_options = hash_gen(0, -2, 4, 176, ex2_path, ex2_full_mp3)
# ex3_options = hash_gen(0, -2, 4, 176, ex3_path, ex3_full_mp3)
# ex4_options = hash_gen(0, -2, 4, 176, ex4_path, ex4_full_mp3)
# ex5_options = hash_gen(0, -12, 3, 132, ex5_path, ex5_full_mp3)
# ex6_options = hash_gen(0, -2, 7, 308, ex6_path, ex6_full_mp3)

# new offsets with 2 points of data
# ex1_options = hash_gen(5, -13, 3.5, 154, ex1_path, ex1_full_mp3)
# ex2_options = hash_gen(-4, -5, 4, 176, ex2_path, ex2_full_mp3)
# ex3_options = hash_gen(-4, -5, 4, 176, ex3_path, ex3_full_mp3)
# ex4_options = hash_gen(-4, -10, 4, 176, ex4_path, ex4_full_mp3)
# ex5_options = hash_gen(10, 4, 3, 132, ex5_path, ex5_full_mp3)
# ex6_options = hash_gen(-4, -17, 7, 308, ex6_path, ex6_full_mp3)


# new offsets with 4 points of data
# ex1_options = hash_gen(5, 3, 3.5, 154, ex1_path, ex1_full_mp3)
# ex2_options = hash_gen(-3, -4, 4, 176, ex2_path, ex2_full_mp3)
# ex3_options = hash_gen(-3, -4, 4, 176, ex3_path, ex3_full_mp3)
# ex4_options = hash_gen(-4, -10, 4, 176, ex4_path, ex4_full_mp3)
# ex5_options = hash_gen(10, 3, 3, 132, ex5_path, ex5_full_mp3)
# ex6_options = hash_gen(-3, -17, 7, 308, ex6_path, ex6_full_mp3)


# new offsets with `-t` to `-to`
# ex1_options = hash_gen(5, 4, 3.5, 154, ex1_path, ex1_full_mp3)
# ex2_options = hash_gen(-3, -4, 4, 176, ex2_path, ex2_full_mp3)
# ex3_options = hash_gen(-3, -4, 4, 176, ex3_path, ex3_full_mp3)
# ex4_options = hash_gen(-3, -10, 4, 176, ex4_path, ex4_full_mp3)
# ex5_options = hash_gen(10, 4, 3, 132, ex5_path, ex5_full_mp3)
# ex6_options = hash_gen(-3, -17, 7, 308, ex6_path, ex6_full_mp3)


# offsets with 1 note high/low
# ex1_options = hash_gen(6, 5, 3.5, 154, ex1_path, ex1_full_mp3)
# ex2_options = hash_gen(-3, -4, 4, 176, ex2_path, ex2_full_mp3)
# ex3_options = hash_gen(-3, -4, 4, 176, ex3_path, ex3_full_mp3)
# ex4_options = hash_gen(-3, -9, 4, 176, ex4_path, ex4_full_mp3)
# ex5_options = hash_gen(11, 5, 3, 132, ex5_path, ex5_full_mp3)
# ex6_options = hash_gen(-3, -16, 7, 308, ex6_path, ex6_full_mp3)


# perfect +/- 3
# ex1_options = hash_gen(4, 3, 3.5, 154, ex1_path, ex1_full_mp3)
# ex2_options = hash_gen(-3, -4, 4, 176, ex2_path, ex2_full_mp3)
# ex3_options = hash_gen(-3, -4, 4, 176, ex3_path, ex3_full_mp3)
# ex4_options = hash_gen(-3, -9, 4, 176, ex4_path, ex4_full_mp3)
# ex5_options = hash_gen(9, 3, 3, 132, ex5_path, ex5_full_mp3)
# ex6_options = hash_gen(-3, -16, 7, 308, ex6_path, ex6_full_mp3)


# working toward +/- 1
ex1_options = hash_gen(6, 1, 3.5, 154, ex1_path, ex1_full_mp3)
ex2_options = hash_gen(-1, -6, 4, 176, ex2_path, ex2_full_mp3)
ex3_options = hash_gen(-1, -6, 4, 176, ex3_path, ex3_full_mp3)
ex4_options = hash_gen(-1, -11, 4, 176, ex4_path, ex4_full_mp3)
ex5_options = hash_gen(11, 1, 3, 132, ex5_path, ex5_full_mp3)
ex6_options = hash_gen(-1, -18, 7, 308, ex6_path, ex6_full_mp3)


ex1 = ReversedExercise.new(ex1_options)
ex2 = Exercise.new(ex2_options)
ex3 = Exercise.new(ex3_options)
ex4 = Exercise.new(ex4_options)
ex5 = ReversedExercise.new(ex5_options)
ex6 = Exercise.new(ex6_options)

range_generator = RangeGenerator.new


def chunk_split_clips(mp3, output_path, combinations)
  ffmpeg = FFmpeg.new(true, true)
  file = mp3.full_mp3_path
  range_generator = RangeGenerator.new

  combinations ||= range_generator.generate_combinations(1, 44, 11)  
  
  combinations.each do |combo|
    start_note, end_note = combo

    output_file_name = combo.join("_") + ".mp3"

    if mp3.reversed
      start_eqn = ((44 - end_note) + mp3.start_offset) * mp3.single_clip_duration
      end_eqn = ( ( (44 - start_note) + 1) + mp3.end_offset) * mp3.single_clip_duration
    else
      start_eqn = ((start_note - 1) + (mp3.start_offset)) * mp3.single_clip_duration
      end_eqn = (end_note + (mp3.end_offset)) * mp3.single_clip_duration
    end

    if start_eqn < 1
      start_eqn = 0
    end

    if end_eqn > mp3.full_clip_length
      end_eqn = mp3.full_clip_length
    end

    if start_eqn > end_eqn || start_eqn == end_eqn
      next
    end

    start_time = ffmpeg.to_padded_time(start_eqn)
    end_time = ffmpeg.to_padded_time(end_eqn)

    ffmpeg.split(file, output_file_name, start_time, end_time, output_path)
  end
end


## Merge clips together

ffmpeg = FFmpeg.new(true, true)
ga_intro = root_path + "/intros/RM_GLOBAL_INTRO.mp3"
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
    ex1_combo = combo 

    # ex1 has special caps due to this being a 'warm up'
    if end_range >= 28
      # if a user can sing higher than C5, we cap him at A4 = 25
      ex1_combo = [start_range, 24]
    end

    if end_range > 18 && end_range < 28
      # if a user can't sing higher than C5, we cap him at D4
      ex1_combo = [start_range, 17]
    end

    if start_range > 28
      # anyone with a lowest note of 28 == not realistic
      # we set the combo to a file we do not have, this will result in 'file does not exist, so ex1 will be skipped'
      ex1_combo = [150, 150]
    end


    ex1 = generate_path_name(files[:ex1_path], ex1_combo)

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

    output_path = files[:output_path] + start_range.to_s + "/"
    output_name = combo.join("_") + ".mp3"
 

    ## only push in files that exist for stitching
    if File.file?(ex1)
      files_to_merge
        .push(ex1_intro)
        .push(ex1)
    end

    if File.file?(ex2)
      files_to_merge
        .push(ex2_intro)
        .push(ex2)
    end

    if File.file?(ex3)
      files_to_merge
        .push(ex3_intro)
        .push(ex3)
    end

    if File.file?(ex4)
      files_to_merge
        .push(ex4_intro)
        .push(ex4)
    end

    if File.file?(ex5)
      files_to_merge
        .push(ex5_intro)
        .push(ex5)
    end

    if File.file?(ex6)
      files_to_merge
        .push(ex6_intro)
        .push(ex6)
    end
      
    files_to_merge.push(files[:ga_closing])
    ffmpeg.merge(files_to_merge, output_path, output_name)
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
  output_path: root_path + "completed_mp3s/download_mp3/"
}


#########################################################
## Generate all combination of clips into folder structure
#########################################################
ex1_comboes = RangeGenerator.new.generate_combinations(1, 44, 0)
ex2_comboes = RangeGenerator.new.generate_combinations(1, 44, 0)
ex3_comboes = RangeGenerator.new.generate_combinations(1, 44, 0)
ex4_comboes = RangeGenerator.new.generate_combinations(1, 44, 0)
ex5_comboes = RangeGenerator.new.generate_combinations(1, 44, 0)
ex6_comboes = RangeGenerator.new.generate_combinations(1, 44, 0)
# Normal (unreversed clips: exercise: 2, 3, 4, 6)
## Ex1 - 6
# chunk_split_clips(ex1, ex1_chunk_clips_output_path, ex1_comboes)
# chunk_split_clips(ex2, ex2_chunk_clips_output_path, ex2_comboes)
# chunk_split_clips(ex3, ex3_chunk_clips_output_path, ex3_comboes)
# chunk_split_clips(ex4, ex4_chunk_clips_output_path, ex4_comboes)
# chunk_split_clips(ex5, ex5_chunk_clips_output_path, ex5_comboes)
# chunk_split_clips(ex6, ex6_chunk_clips_output_path, ex6_comboes)

#########################################################
# this will stitch together all the combinations
# run this after you've run all the examples above
#########################################################
# Instructions
# 1. Run Ex1-6 above (#chunk_split_clips)
# 2. Run combinations / #generate_complete_clips
# 3. Profit
#########################################################
combinations = range_generator.generate_combinations(1, 44, 11)
generate_complete_clips(combinations, files)

# if you experience clips playing the intro, and nothing else
# check your file's sample rate
# all the exercise clips are recorded in 44,100
# intro should also be 44,100
# try brew install sox, and then run the command
## Change sample rate (again two possibilities)
# sox input.mp3 -r 8000 output.wav
# sox input.mp3 output.wav rate 8000
# Newer versions of SoX also support
# sox input.mp3 output.wav rate 8k 
