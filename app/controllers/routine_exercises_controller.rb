class RoutineExercisesController < ApplicationController

  before_action :set_routine
  before_action :set_routine_exercise, only: [:destroy]

  def create
    @routine_exercise = @routine.routine_exercises.build(routine_exercise_params)
    @routine_exercise.save
    redirect_to @routine, notice: 'Exercise created successfully'
  end
  
  def destroy
    @routine_exercise.destroy
    redirect_to @routine, notice: 'Exercise removed successfully'
  end

  private

  def set_routine
    @routine = Routine.find(params[:routine_id])
  end

  def set_routine_exercise
    @routine_exercise = @routine.routine_exercises.find(params[:id])
  end

  def routine_exercise_params
    params.require(:routine_exercise).permit(:sets, :reps, :weight, :duration, :exercise_id)
  end
  
end
