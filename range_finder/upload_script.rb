require './aws_wrapper.rb'
require './ffmpeg_tools.rb'

# generate array of all combinations and allow for min length (gap)
def generate_arr_of_all_combinations(start_range, end_range, gap)
  combinations = []

  start_range.upto(end_range - gap) do |x|
    x.upto(end_range) do |y|
      next if (x + gap) > y
      combinations.push([x, y])
    end
  end

  combinations
end


def generate_output_file_name(path, name)
  path + name
end

# load file paths
# local_path = "/Users/itjsimmyh/Desktop/rf_sounds/"
# upload_root_path = "static.masterclass.com/ca_tuner/exercise-downloadable-mp3s"
# generate(1, 59, 11, true)
# generate(1, 59, 11, true, { failed: true, new_start_index: index_# })
def generate(start_range=1, end_range=59, gap=11, run_flag=false, prior_upload={ failed: false }, local_path="/Users/itsjimmyh/Desktop/rf_sounds/")
  region = 'us-west-2'
  s3 = AWS::S3.new(region: region)

  # spot = index of last merged combination
  spot = 0
  combinations = generate_arr_of_all_combinations(start_range, end_range, gap)
  
  if prior_upload[:failed]
    combinations = combinations[prior_upload[:new_start_index]..-1]
  end

  combinations.each_with_index do |range, index|
    start_note, end_note = range
   
    # generate the format in to create the list of files to merge based on pick_two[x..y]
    files_to_merge = generate_downloadable_mp3_list(local_path, start_note, end_note)

    # merge the files
    # "#{start_note}_#{end_note} ==> 1_1.mp3 || 1_59.mp3
    semantic_file_name = "#{start_note}_#{end_note}"
    #output_file_name = generate_output_file_name(local_path, semantic_file_name)

    file_path = ffmpeg_merge(files_to_merge, semantic_file_name, run_flag)
    p "---->>> Merged File <<<----"
    p "---->>> Merged File <<<----"
    p "---->>> Merged File <<<----"

    # TODO pass file to upload_to_s3 method
    # upload_path = upload_root_path + "/#{ start_note  }/#{ start_note }_#{ end_note }.mp3"

    # spot = index

    # if upload_to_s3(s3, file_path, upload_path, nil)
    #   # successful upload to s3, tell me the abs_index of all_combinations & the combination [x, y]
    #   if prior_upload[:failed]
    #     # previously failed, offset the abs_index by the new_start_index
    #     abs_index = spot + prior_upload[:new_start_index]
    #     p "successfully uploaded to s3 @ abs index: #{ abs_index }, combination: #{ combinations[spot] }"
    #   else
    #     # didn't fail, abs_index is the spot(index)
    #     p "successfully uploaded to s3 @ abs index: #{ spot }, combination: #{ combinations[spot] }"
    #   end
    # else
    #   # failed upload to s3
    #   if prior_upload[:failed]
    #     abs_index = spot + prior_upload[:new_start_index]
    #     p "failed upload to s3 @ abs index: #{ abs_index }, combination: #{ combinations[spot] }"
    #     return
    #   else
    #     p "failed upload to s3 @ abs index: #{ spot }, combination: #{ combinations[spot] }"
    #     return
    #   end
    # end
  end

#x  if prior_upload[:failed]
#x    number = spot + prior_upload[:new_start_index]
#x    p "merged file was at index: #{ number }, combination: #{ combinations[number - prior_upload[:new_start_index]] }"
#x  else
#x    p "merged file was at index: #{ spot }, combination: #{ combinations[spot] }"
#x  end
#x
  nil
end


# region = 'us-west-2'
# s3 = AWS::S3.new(region: region)

# TODO
def upload_to_s3(s3, file_name, upload_directory, bucket_name)
  # key = File.basename(file_name)

  if s3.buckets[bucket_name].objects[key].write(file: file_name)
    true
  else
    false
  end
end


