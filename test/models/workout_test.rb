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
end
