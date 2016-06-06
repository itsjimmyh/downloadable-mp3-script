module Audio

  FFMPEG = `which ffmpeg`.chomp

  ## Merge Audio Files
  # provide: array of files, output name, output_path, and a run flag
  # path = "/Users/itsjimmyh/Desktop/rf_sounds/"
  # View the Command:
  #   Audio.ffmpeg_merge(["#{path}1.mp3", "#{path}2.mp3"], "1_2.mp3", "/Users/itsjimmyh/Desktop/rf_sounds/")
  # Run the Command:
  #   Audio.ffmpeg_merge(["#{path}1.mp3", "#{path}2.mp3"], "1_2.mp3", "/Users/itsjimmyh/Desktop/rf_sounds/", true)
  def Audio.ffmpeg_merge(files, output_file_name, output_path, run_flag=false)
    files_to_merge = files.join("|")
    command = "#{ FFMPEG } -i 'concat:#{ files_to_merge }' -acodec copy #{ output_path }#{ output_file_name }" 
    
    if run_flag
      p "in #ffmpeg_merge"
      `#{ command }`
    else
      p command
    end

    output_path + output_file_name
  end


  ## Split Audio File
  # provide: file you want to split, output file name, start_time, end_time, output path, run flag
  # View the Command:
  #   Audio.ffmpeg_split(input_file, output_file, "00:00:01.53", "00:00:02.59", "/Users/itsjimmyh/Desktop/rf_sounds/"
  # Run the Command
  #   Audio.ffmpeg_split(input_file, output_file, "00:00:01.53", "00:00:02.59", "/Users/itsjimmyh/Desktop/rf_sounds/", true)
  def Audio.ffmpeg_split(input, output_name, start_time, end_time, output_path, run_flag=false)
    command = "#{ FFMPEG } -i #{ input } -ss #{ start_time } -t #{ end_time } -acodec copy #{ output_path }#{ output_name }"

    if run_flag
      p "in #ffmpeg_split"
      `#{ command }`
    else
      p command
    end

    p output_path + output_name
  end
end


module Audio
  module Helpers

    ## convert seconds to padded time
    #   180.186 --> "00:03:00.186"
    def Helpers.to_padded_time(time_in_seconds)
      Time.at(time_in_seconds).utc.round(3).strftime("%H:%M:%S.%L")
    end

  end
end
