class Exercise

  attr_accessor :start_offset, :end_offset, :clip_duration,
                :root_directory_path

  def initialize(options={})
    @start_offset = options[:start_offset]
    @end_offset = options[:end_offset]
    @clip_duration = options[:clip_duration]
    @root_directory_path = options[:root_directory_path]
  end
end
