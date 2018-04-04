require 'test_helper'

class WorkoutExerciseTest < ActiveSupport::TestCase
  def setup
    @workout_exercise = workout_exercises(:one)
  end

  test 'valid_model' do
    assert @workout_exercise.valid?
  end

  test 'invalid_without_workout' do
    @workout_exercise = WorkoutExercise.new(exercise: exercises(:jump))
    refute @workout_exercise.valid?
    assert_equal ['must exist'], @workout_exercise.errors[:workout]
  end

  test 'invalid_without_exercise' do
    @workout_exercise = WorkoutExercise.new(workout: workouts(:today))
    refute @workout_exercise.valid?
    assert_equal ['must exist'], @workout_exercise.errors[:exercise]
  end

  test 'belongs_to_workout' do
    assert_respond_to @workout_exercise, :workout
  end

  test 'belongs_to_exercise' do
    assert_respond_to @workout_exercise, :exercise
  end
end
