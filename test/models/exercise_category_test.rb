require 'test_helper'

class ExerciseCategoryTest < ActiveSupport::TestCase
  test 'valid_model' do
    category = exercise_categories(:aerobic)
    assert category.valid?
  end

  test 'invalid_without_name' do
    category = ExerciseCategory.new
    refute category.valid?
    assert_equal category.errors[:name], ['can\'t be blank']
  end
end
