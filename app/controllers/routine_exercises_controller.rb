class RoutineExercisesController < ApplicationController

  before_action :set_routine
  before_action :set_routine_exercise, only: [:edit, :update, :destroy]
  before_action :set_exercises, only: [:new, :edit, :create, :update]

  def new
    @routine_exercise = @routine.routine_exercises.build
  end

  def edit
  end

  def create
    @routine_exercise = @routine.routine_exercises.build(routine_exercise_params)
    if @routine_exercise.save
      redirect_to @routine, notice: 'Exercise created successfully'
    else
      render :new
    end
  end

  def update
    if @routine_exercise.update(routine_exercise_params)
      redirect_to @routine, notice: 'Exercise updated successfully'
    else
      render :edit
    end
  end

  def destroy
    @routine_exercise.destroy
    redirect_to @routine, notice: 'Exercise removed successfully'
  end

  private

  def set_exercises
    @exercises = current_user.exercises.order(:name)
  end

  def set_routine
    @routine = current_user.routines.find(params[:routine_id])
  end

  def set_routine_exercise
    @routine_exercise = @routine.routine_exercises.find(params[:id])
  end

  def routine_exercise_params
    params.require(:routine_exercise).permit(:sets, :reps, :weight, :duration, :exercise_id)
  end
  
end
