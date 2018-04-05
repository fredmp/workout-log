class ExercisesController < ApplicationController

  before_action :set_exercise, only: [:show, :edit, :update, :destroy]

  def index
    @exercises = if params[:category_id]
      current_user.exercises.where(category_id: params[:category_id])
    else
      current_user.exercises.all
    end.order(:name)
  end

  def show
  end

  def new
    @exercise = current_user.exercises.build
  end

  def create
    @exercise = current_user.exercises.build(exercise_params)
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
    redirect_to exercises_path, notice: 'Exercise removed successfully'
  end

  private

  def set_exercise
    @exercise = current_user.exercises.find(params[:id])
  end

  def exercise_params
    params.require(:exercise).permit(:name, :description, :exercise_category_id)
  end
  
end
