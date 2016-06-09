class FFmpeg

  attr_reader :ffmpeg
  attr_accessor :should_run, :debug

  def initialize(should_run=false, debug=false)
    @debug = debug
    @should_run = should_run
    @ffmpeg = `which ffmpeg`.chomp
  end

  def split(input, output_name, start_time, end_time, output_path)
    output_file = File.join(output_path, output_name)

    run("#{ @ffmpeg } -i #{ input } -ss #{ start_time } -t #{ end_time } -acodec copy #{ output_file }")

    log(output_file)
  end

  def merge(arr_files, output_path, output_name)
    files_to_merge = arr_files.join("|")
    output_file = File.join(output_path, output_name)

    run("#{ @ffmpeg } -i 'concat:#{ files_to_merge }' -acodec copy #{ output_file }")

    log(output_file)
  end


  private
  def log(info)
    if debug
      p info
    end
  end

  def run(command)
    if should_run
      log(command)
      log(`#{ command }`)
    else
      log(command)
    end
  end
end
