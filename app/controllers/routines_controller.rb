class RoutinesController < ApplicationController

  before_action :set_routine, only: [:show, :edit, :update, :destroy]
  before_action :set_exercises, only: [:show]

  def index
    @routines = current_user.routines.order(:name)
  end

  def show
  end

  def new
    @routine = current_user.routines.build
  end

  def create
    @routine = current_user.routines.build(routine_params)
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
    @routine = current_user.routines.find(params[:id])
  end

  def set_exercises
    @exercises = current_user.exercises.order(:name)
  end

  def routine_params
    params.require(:routine).permit(:name, :description)
  end
  
end
