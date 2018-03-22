class RoutinesController < ApplicationController

  before_action :set_routine, only: [:show, :edit, :update, :destroy]
  before_action :set_exercises, only: [:show]

  def index
    @routines = Routine.all.order(:name)
  end

  def show
  end

  def new
    @routine = Routine.new
  end

  def create
    @routine = Routine.new(routine_params)
    if @routine.save
      redirect_to @routine, notice: 'Routine created successfully'
    else
      render :new
    end
  end

  def update
    if @routine.update(routine_params)
      redirect_to @routine, notice: 'Routine updated successfully'
    else
      render :edit
    end
  end
  
  def destroy
    @routine.destroy
    redirect_to routines_path
  end

  private

  def set_routine
    @routine = Routine.find(params[:id])
  end

  def set_exercises
    @exercises = Exercise.all
  end

  def routine_params
    params.require(:routine).permit(:name, :description)
  end
  
end
