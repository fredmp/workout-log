class WorkoutsController < ApplicationController

  before_action :set_workout, only: [:show, :edit, :update, :destroy]
  before_action :set_exercises, only: [:show]

  def index
    @workouts = current_user.workouts.order(date: :desc)
  end

  def show
  end

  def new
    @routines = current_user.routines.order(:name)
    @workout = current_user.workouts.build(date: DateTime.current.change(sec: 0))
  end

  def create
    @workout = current_user.workouts.build(workout_params)
    @workout.build_from_routine(current_user.routines.find_by_id(params[:routine][:id])) if params[:routine]
    if @workout.save
      redirect_to workouts_path, notice: 'Workout created successfully'
    else
      render :new
    end
  end

  def update
    if @workout.update(workout_params)
      redirect_to workouts_path, notice: 'Workout updated successfully'
    else
      render :edit
    end
  end
  
  def destroy
    @workout.destroy
    redirect_to workouts_path, notice: 'Workout removed successfully'
  end

  private

  def set_workout
    @workout = current_user.workouts.find(params[:id])
  end

  def set_exercises
    @exercises = current_user.exercises.order(:name)
  end

  def workout_params
    params.require(:workout).permit(:date, :duration, :comments)
  end
  
end
