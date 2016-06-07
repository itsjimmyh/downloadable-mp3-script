class FFmpeg

  attr_reader :ffmpeg
  attr_accessor :should_run, :debug

  def initialize()
    @debug = false
    @should_run = false
    @ffmpeg = `which ffmpeg`.chomp
  end


  def split(input, output_name, start_time, end_time, output_path)
    output_file = File.join(output_path, output_name)

    run("#{ @ffmpeg } -i #{ input } -ss #{ start_time } -t #{ end_time } -acodec copy #{ output_file }")

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
