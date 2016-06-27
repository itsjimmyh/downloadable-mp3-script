class Exercise

  attr_accessor :start_offset, :end_offset, :single_clip_duration,
                :root_directory_path, :full_clip_length, :full_mp3_path,
                :generator, :clip_start_number, :clip_end_number, :gap

  attr_reader :reversed

  def initialize(options={})
    @start_offset = options[:start_offset]
    @end_offset = options[:end_offset]
    @single_clip_duration = options[:single_clip_duration]
    @full_clip_length = options[:full_clip_length]
    @root_directory_path = options[:root_directory_path]
    @full_mp3_path = options[:full_mp3_path]
    @generator = options[:generator]
    @clip_start_number = options[:clip_start_number]
    @clip_end_number = options[:clip_end_number]
    @gap = options[:gap]
    @reversed = false
  end

  def generate_combinations
    @generator.generate_combinations(@clip_start_number, @clip_end_number, @gap)
  end
end
