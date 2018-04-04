require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:user)
  end

  test 'valid_model' do
    assert @user.valid?
  end

  test 'has_many_exercises' do
    assert_respond_to @user, :exercises
  end

  test 'has_many_routines' do
    assert_respond_to @user, :routines
  end

  test 'has_many_workouts' do
    assert_respond_to @user, :workouts
  end
end
