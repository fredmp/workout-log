class ExercisesController < ApplicationController

  before_action :set_exercise, only: [:show, :edit, :update, :destroy]

  def index
    @exercise_category_id = params[:exercise_category_id]
    @body_part_id = params[:body_part_id]

    @exercises = current_user.exercises
    @exercises = @exercises.where(exercise_category_id: @exercise_category_id) if @exercise_category_id.present?
    @exercises = @exercises.joins(:body_parts).where({ body_parts: { id: @body_part_id } }) if @body_part_id.present?
    @exercises.order(:name)
  end

  def show
  end

  def new
    @exercise = Exercise.new(exercise_category_id: params[:exercise_category_id])
  end

  def create
    unless valid_category?
      @exercise = Exercise.new(exercise_params)
      flash[:alert] = I18n.t(:required, scope: [:categories])
      render :new
      return
    end
    @exercise = current_user.exercises.build(exercise_params)
    if @exercise.save
      redirect_to exercises_path, notice: I18n.t(:created, scope: [:exercises])
    else
      render :new
    end
  end

  def update
    unless valid_category?
      flash[:alert] = I18n.t(:required, scope: [:categories])
      render :new
      return
    end
    if @exercise.update(exercise_params)
      redirect_to exercises_path, notice: I18n.t(:updated, scope: [:exercises])
    else
      render :edit
    end
  end
  
  def destroy
    @exercise.destroy
    redirect_to exercises_path, notice: I18n.t(:removed, scope: [:exercises])
  end

  private

  def set_exercise
    @exercise = current_user.exercises.find(params[:id])
  end

  def exercise_params
    params.require(:exercise).permit(:name, :description, :exercise_category_id, { available_field_ids: [] }, { body_part_ids: [] })
  end

  def valid_category?
    !!current_user.exercise_categories.detect { |c| c.id == exercise_params[:exercise_category_id].to_i }
  end
end
