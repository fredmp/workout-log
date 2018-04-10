class SettingsController < ApplicationController
  def index
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
