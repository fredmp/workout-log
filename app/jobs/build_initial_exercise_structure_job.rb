class BuildInitialExerciseStructureJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.where(id: user_id.to_i).first if user_id
    ExerciseStructureBuilder.new(user).build if user
  end
end
