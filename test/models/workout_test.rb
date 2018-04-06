require 'test_helper'

class WorkoutTest < ActiveSupport::TestCase
  def setup
    @workout = workouts(:today)
  end

  test 'valid_model' do
    assert @workout.valid?
  end

  test 'invalid_without_date' do
    @workout = Workout.new
    refute @workout.valid?
    assert_equal ['can\'t be blank'], @workout.errors[:date]
  end

  test 'belongs_to_user' do
    assert_respond_to @workout, :user
  end

  test 'has_many_exercises' do
    assert_respond_to @workout, :workout_exercises
  end

  test '#to_s' do
    assert_equal @workout.date.strftime('%a - %b %d, %Y - %H:%M'), @workout.to_s
  end

  test '#build_from_routine' do
    workout = Workout.new
    workout.build_from_routine(routines(:monday))
    assert_equal 1, workout.workout_exercises.size
    assert_equal 'Jump Rope', workout.workout_exercises.first.exercise.name
  end
end
