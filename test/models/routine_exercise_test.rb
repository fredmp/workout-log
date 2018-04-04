require 'test_helper'

class RoutineExerciseTest < ActiveSupport::TestCase
  def setup
    @routine_exercise = routine_exercises(:one)
  end

  test 'valid_model' do
    assert @routine_exercise.valid?
  end

  test 'invalid_without_routine' do
    @routine_exercise = RoutineExercise.new(exercise: exercises(:jump))
    refute @routine_exercise.valid?
    assert_equal ['must exist'], @routine_exercise.errors[:routine]
  end

  test 'invalid_without_exercise' do
    @routine_exercise = RoutineExercise.new(routine: routines(:monday))
    refute @routine_exercise.valid?
    assert_equal ['must exist'], @routine_exercise.errors[:exercise]
  end

  test 'belongs_to_routine' do
    assert_respond_to @routine_exercise, :routine
  end

  test 'belongs_to_exercise' do
    assert_respond_to @routine_exercise, :exercise
  end
end
