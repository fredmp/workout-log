require 'test_helper'

class RoutineTest < ActiveSupport::TestCase
  def setup
    @routine = routines(:monday)
  end

  test 'valid_model' do
    assert @routine.valid?
  end

  test 'invalid_without_name' do
    @routine = Routine.new
    refute @routine.valid?
    assert_equal ['can\'t be blank'], @routine.errors[:name]
  end

  test 'belongs_to_user' do
    assert_respond_to @routine, :user
  end

  test 'has_many_exercises' do
    assert_respond_to @routine, :routine_exercises
  end
end
