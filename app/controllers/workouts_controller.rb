class WorkoutsController < ApplicationController

  before_action :set_workout, only: [:show, :edit, :update, :destroy]
  before_action :set_exercises, only: [:show]

  def index
    @workouts = Workout.all.order(:date)
  end

  def show
  end

  def new
    @workout = Workout.new
  end

  def create
    @workout = Workout.new(workout_params)
    if @workout.save
      redirect_to @workout, notice: 'Workout created successfully'
    else
      render :new
    end
  end

  def update
    if @workout.update(workout_params)
      redirect_to @workout, notice: 'Workout updated successfully'
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
