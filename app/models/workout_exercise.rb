# == Schema Information
#
# Table name: workout_exercises
#
#  id          :integer          not null, primary key
#  exercise_id :integer
#  workout_id  :integer
#  sets        :integer
#  reps        :integer
#  weight      :decimal(, )
#  duration    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_workout_exercises_on_exercise_id  (exercise_id)
#  index_workout_exercises_on_workout_id   (workout_id)
#

class WorkoutExercise < ApplicationRecord
  belongs_to :exercise
  belongs_to :workout
end
