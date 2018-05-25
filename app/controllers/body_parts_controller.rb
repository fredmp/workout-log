class BodyPartsController < ApplicationController
  before_action :set_body_part, only: [:show, :edit, :update, :destroy]

  def index
    @body_parts = current_user.body_parts.all.order(:name)
  end

  def show
  end

  def new
    @body_part = current_user.body_parts.build
  end

  def create
    @body_part = current_user.body_parts.build(body_part_params)
    if @body_part.save
      redirect_to body_parts_path, notice: I18n.t(:created, scope: [:body_parts])
    else
      render :new
    end
  end

  def update
    if @body_part.update(body_part_params)
      redirect_to body_parts_path, notice: I18n.t(:updated, scope: [:body_parts])
    else
      render :edit
    end
  end
  
  def destroy
    @body_part.destroy
    redirect_to body_parts_path, notice: I18n.t(:removed, scope: [:body_parts])
  end

  private

  def set_body_part
    @body_part = current_user.body_parts.find(params[:id])
  end

  def body_part_params
    params.require(:body_part).permit(:name)
  end
end
