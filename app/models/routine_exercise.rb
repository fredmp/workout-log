# == Schema Information
#
# Table name: routine_exercises
#
#  id          :integer          not null, primary key
#  exercise_id :integer
#  routine_id  :integer
#  sets        :integer
#  reps        :integer
#  weight      :decimal(, )
#  duration    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_routine_exercises_on_exercise_id  (exercise_id)
#  index_routine_exercises_on_routine_id   (routine_id)
#
# Foreign Keys
#
#  fk_rails_...  (exercise_id => exercises.id)
#  fk_rails_...  (routine_id => routines.id)
#

class RoutineExercise < ApplicationRecord
  belongs_to :routine
  belongs_to :exercise
end
