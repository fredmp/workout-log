require 'test_helper'

class ExerciseTest < ActiveSupport::TestCase
  def setup
    @exercise = exercises(:bench)
  end

  test 'valid_model' do
    assert @exercise.valid?
  end

  test 'invalid_without_name' do
    @exercise = Exercise.new(exercise_category: exercise_categories(:aerobic))
    refute @exercise.valid?
    assert_equal ['can\'t be blank'], @exercise.errors[:name]
  end

  test 'invalid_without_category' do
    @exercise = Exercise.new(name: 'Running')
    refute @exercise.valid?
    assert_equal ['must exist', 'can\'t be blank'], @exercise.errors[:exercise_category]
  end

  test 'belongs_to_user' do
    assert_respond_to @exercise, :user
  end
end
