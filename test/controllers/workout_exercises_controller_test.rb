require 'test_helper'

class WorkoutExercisesControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  def setup
    sign_in users(:user)
    @workout = workouts(:today)
  end

  test 'new' do
    get new_workout_workout_exercise_url(@workout.id)
    assert_response :success
  end

  test 'create' do
    exercise = exercises(:bench)
    post workout_workout_exercises_url(@workout.id, {
      workout_exercise: {
        sets: 4,
        reps: 10,
        weight: 22,
        duration: 40,
        exercise_id: exercise.id
      }
    })
    assert_equal 'Exercise created successfully', flash[:notice]
    assert_redirected_to workout_url(@workout.id)
  end

  test 'update' do
    exercise = exercises(:bench)
    put workout_workout_exercise_url(@workout.id, workout_exercises(:one).id, {
      workout_exercise: {
        sets: 4,
        reps: 8,
        weight: 44,
        duration: 44,
        exercise_id: exercise.id
      }
    })
    assert_equal 'Exercise updated successfully', flash[:notice]
    assert_redirected_to workout_url(@workout.id)
  end

  test 'destroy' do
    delete workout_workout_exercise_url(@workout.id, workout_exercises(:one).id)
    assert_equal 'Exercise removed successfully', flash[:notice]
    assert_redirected_to workout_url(@workout.id)
  end
end
