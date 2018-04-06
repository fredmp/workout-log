require 'test_helper'

class RoutineExercisesControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  def setup
    sign_in users(:user)
    @routine = routines(:tuesday)
  end

  test 'new' do
    get new_routine_routine_exercise_url(@routine.id)
    assert_response :success
  end

  test 'create' do
    exercise = exercises(:bench)
    post routine_routine_exercises_url(@routine.id, {
      routine_exercise: {
        sets: 4,
        reps: 10,
        weight: 22,
        duration: 40,
        exercise_id: exercise.id
      }
    })
    assert_equal 'Exercise created successfully', flash[:notice]
    assert_redirected_to routine_url(@routine.id)
  end

  test 'update' do
    exercise = exercises(:bench)
    put routine_routine_exercise_url(@routine.id, routine_exercises(:two).id, {
      routine_exercise: {
        sets: 4,
        reps: 8,
        weight: 44,
        duration: 44,
        exercise_id: exercise.id
      }
    })
    assert_equal 'Exercise updated successfully', flash[:notice]
    assert_redirected_to routine_url(@routine.id)
  end

  test 'destroy' do
    delete routine_routine_exercise_url(@routine.id, routine_exercises(:two).id)
    assert_equal 'Exercise removed successfully', flash[:notice]
    assert_redirected_to routine_url(@routine.id)
  end
end
