require 'exercise'

class ReversedExercise < Exercise
  attr_reader :reversed

  def initialize(options={})
    super
    @reversed = true
  end
end
