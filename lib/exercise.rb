class Exercise

  attr_accessor :start_offset, :end_offset, :single_clip_duration,
                :root_directory_path, :full_clip_length, :full_mp3_path

  def initialize(options={})
    @start_offset = options[:start_offset]
    @end_offset = options[:end_offset]
    @single_clip_duration = options[:single_clip_duration]
    @full_clip_length = options[:full_clip_length]
    @root_directory_path = options[:root_directory_path]
    @full_mp3_path = options[:full_mp3_path]
  end
end
