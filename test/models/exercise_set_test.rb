require 'test_helper'

class ExerciseSetTest < ActiveSupport::TestCase
  def setup
    @set = exercise_sets(:one)
  end

  test 'valid_model' do
    assert @set.valid?
  end

  test 'invalid_without_date' do
    @set = ExerciseSet.new
    refute @set.valid?
    assert_equal ['At least one field must be present'], @set.errors[:base]
  end

  test '#to_s' do
    assert_equal '%a - %b %d, %Y - %H:%M', @set.to_s
  end
end
