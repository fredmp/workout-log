class WorkoutExercisesController < ApplicationController

  before_action :set_workout
  before_action :set_workout_exercise, only: [:edit, :update, :destroy]
  before_action :set_exercises, only: [:new, :edit, :create, :update]

  def new
    @workout_exercise = @workout.workout_exercises.build
  end

  def edit
  end

  def create
    @workout_exercise = @workout.workout_exercises.build(workout_exercise_params)
    if @workout_exercise.save
      redirect_to @workout, notice: I18n.t(:created, scope: [:exercises])
    else
      render :new
    end
  end

  def update
    if @workout_exercise.update(workout_exercise_params)
      redirect_to @workout, notice: I18n.t(:updated, scope: [:exercises])
    else
      render :edit
    end
  end

  def destroy
    @workout_exercise.destroy
    redirect_to @workout, notice: I18n.t(:removed, scope: [:exercises])
  end

  private

  def set_exercises
    @exercises = current_user.exercises.order(:name)
  end

  def set_workout
    @workout = current_user.workouts.find(params[:workout_id])
  end

  def set_workout_exercise
    @workout_exercise = @workout.workout_exercises.find(params[:id])
  end

  def workout_exercise_params
    params.require(:workout_exercise).permit(
      :exercise_id,
      :weight_unit,
      :length_unit,
      exercise_sets_attributes: [:id, :reps, :weight, :duration, :distance, :_destroy]
    )
  end
end
