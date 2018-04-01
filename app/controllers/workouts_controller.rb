class WorkoutsController < ApplicationController

  before_action :set_workout, only: [:show, :edit, :update, :destroy]
  before_action :set_exercises, only: [:show]

  def index
    @workouts = Workout.all.order(date: :desc)
  end

  def show
  end

  def new
    @routines = Routine.all.order(:name)
    @workout = Workout.new(date: DateTime.current.change(sec: 0))
  end

  def create
    @workout = Workout.new(workout_params)
    @workout.build_from_routine(Routine.find_by_id(params[:routine][:id])) if params[:routine]
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
    redirect_to workouts_path
  end

  private

  def set_workout
    @workout = Workout.find(params[:id])
  end

  def set_exercises
    @exercises = Exercise.all
  end

  def workout_params
    params.require(:workout).permit(:date, :duration, :comments)
  end
  
end
