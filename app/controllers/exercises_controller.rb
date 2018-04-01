class ExercisesController < ApplicationController

  before_action :set_exercise, only: [:show, :edit, :update, :destroy]

  def index
    @exercises = if params[:category_id]
      Exercise.where(category_id: params[:category_id])
    else
      Exercise.all
    end.order(:name)
  end

  def show
  end

  def new
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.new(exercise_params)
    if @exercise.save
      redirect_to exercises_path, notice: 'Exercise created successfully'
    else
      render :new
    end
  end

  def update
    if @exercise.update(exercise_params)
      redirect_to exercises_path, notice: 'Exercise updated successfully'
    else
      render :edit
    end
  end
  
  def destroy
    @exercise.destroy
    redirect_to exercises_path
  end

  private

  def set_exercise
    @exercise = Exercise.find(params[:id])
  end

  def exercise_params
    params.require(:exercise).permit(:name, :description, :exercise_category_id)
  end
  
end
