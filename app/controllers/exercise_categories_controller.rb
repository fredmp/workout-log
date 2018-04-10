class ExerciseCategoriesController < ApplicationController
  before_action :set_exercise_category, only: [:show, :edit, :update, :destroy]

  def index
    @exercise_categories = current_user.exercise_categories.all.order(:name)
  end

  def show
  end

  def new
    @exercise_category = current_user.exercise_categories.build
  end

  def create
    @exercise_category = current_user.exercise_categories.build(exercise_category_params)
    if @exercise_category.save
      redirect_to exercise_categories_path, notice: 'Category created successfully'
    else
      render :new
    end
  end

  def update
    if @exercise_category.update(exercise_category_params)
      redirect_to exercise_categories_path, notice: 'Category updated successfully'
    else
      render :edit
    end
  end
  
  def destroy
    @exercise_category.destroy
    redirect_to exercise_categories_path, notice: 'Category removed successfully'
  end

  private

  def set_exercise_category
    @exercise_category = current_user.exercise_categories.find(params[:id])
  end

  def exercise_category_params
    params.require(:exercise_category).permit(:name, :description)
  end
end
