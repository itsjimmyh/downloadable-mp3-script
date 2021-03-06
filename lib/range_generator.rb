class RangeGenerator

  def initialize()
  end

  def generate_combinations(start_range, end_range, gap)
    combinations = []

    start_range.upto(end_range - gap) do |x|
      x.upto(end_range) do |y|
        next if (x + gap) > y
        combinations.push([x, y])
      end
    end

    combinations
  end

  def to_padded_time(time_in_seconds, rounding=3)
    Time.at(time_in_seconds).utc.round(rounding).strftime("%H:%M:%S.%L")
  end
end
