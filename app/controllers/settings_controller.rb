class SettingsController < ApplicationController
  def index
  end

  def set_weight_unit
    begin
      current_user.update(weight_unit: params[:unit]) if Settings::WEIGHT_MEASURE_UNITS.keys.map { |u| u.to_s }.include?(params[:unit])
      head :ok
    rescue
      head :internal_server_error
    end
  end

  def set_length_unit
    begin
      current_user.update(length_unit: params[:unit]) if Settings::LENGTH_MEASURE_UNITS.keys.map { |u| u.to_s }.include?(params[:unit])
      head :ok
    rescue
      head :internal_server_error
    end
  end

  def restore
    begin
      BuildInitialExerciseStructureJob.perform_later(current_user.id)
      result = { message: t(:restored_successfully, scope: [:common]), notification: :notice }
    rescue => exception
      result = { message: t(:restore_error, scope: [:common]), notification: :alert }
    end
    flash[result[:notification]] = result[:message]
    redirect_to settings_index_url
  end
end
