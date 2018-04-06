require 'test_helper'

class ExercisesControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  def setup
    sign_in users(:user)
  end

  test 'index' do
    get exercises_url
    assert_response :success
  end

  test 'show' do
    get exercise_url(exercises(:jump).id)
    assert_response :success
  end

  test 'new' do
    get new_exercise_url
    assert_response :success
  end

  test 'create' do
    post exercises_url({
      exercise: {
        name: 'Name',
        description: 'Description',
        exercise_category_id: exercise_categories(:aerobic).id
      }
    })
    assert_equal 'Exercise created successfully', flash[:notice]
    assert_redirected_to exercises_url
  end

  test 'update' do
    put exercise_url(exercises(:jump).id, {
      exercise: {
        name: 'Shoulders',
        description: 'Description',
        exercise_category_id: exercise_categories(:strength).id
      }
    })
    assert_equal 'Exercise updated successfully', flash[:notice]
    assert_redirected_to exercises_url
  end

  test 'destroy' do
    delete exercise_url(exercises(:jump).id)
    assert_equal 'Exercise removed successfully', flash[:notice]
    assert_redirected_to exercises_url
  end
end
