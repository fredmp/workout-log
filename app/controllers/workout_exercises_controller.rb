class WorkoutExercisesController < ApplicationController

  before_action :set_workout
  before_action :set_workout_exercise, only: [:destroy]

  def create
    @workout_exercise = @workout.workout_exercises.build(workout_exercise_params)
    @workout_exercise.save
    redirect_to @workout, notice: 'Exercise created successfully'
  end
  
  def destroy
    @workout_exercise.destroy
    redirect_to @workout, notice: 'Exercise removed successfully'
  end

  private

  def set_workout
    @workout = Workout.find(params[:workout_id])
  end

  def set_workout_exercise
    @workout_exercise = @workout.workout_exercises.find(params[:id])
  end

  def workout_exercise_params
    params.require(:workout_exercise).permit(:sets, :reps, :weight, :duration, :exercise_id)
  end
  
end
