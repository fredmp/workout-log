require 'test_helper'

class WorkoutsControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  def setup
    sign_in users(:user)
  end

  test 'index' do
    get workouts_url
    assert_response :success
  end

  test 'show' do
    get workout_url(workouts(:today).id)
    assert_response :success
  end

  test 'new' do
    get new_workout_url
    assert_response :success
  end

  test 'create' do
    post workouts_url({
      workout: {
        date: DateTime.current,
        duration: 20,
        comments: 'Comments'
      }
    })
    assert_equal 'Workout created successfully', flash[:notice]
    assert_redirected_to workouts_url
  end

  test 'update' do
    put workout_url(workouts(:today).id, {
      workout: {
        duration: 60,
        comments: 'Comments'
      }
    })
    assert_equal 'Workout updated successfully', flash[:notice]
    assert_redirected_to workouts_url
  end

  test 'destroy' do
    delete workout_url(workouts(:today).id)
    assert_equal 'Workout removed successfully', flash[:notice]
    assert_redirected_to workouts_url
  end
end
