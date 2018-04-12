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

  def restore
    result = if ExerciseStructureBuilder.new(current_user).build
      { message: 'Exercises restored successfully', notification: :notice }
    else
      { message: 'There was an error when restoring the exercises', notification: :alert }
    end
    flash[result[:notification]] = result[:message]
    redirect_to settings_index_url
  end
end
