# == Schema Information
#
# Table name: routine_exercises
#
#  id          :integer          not null, primary key
#  exercise_id :integer
#  routine_id  :integer
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

  has_many :exercise_sets, as: :setable, dependent: :destroy

  alias_attribute :sets, :exercise_sets

  %w(reps weight duration).each do |name|
    define_method(name.to_sym) do
      return 0 if sets.empty?
      sets.reduce(0) do |accumulator, current|
        accumulator + current.send(name.to_sym)
      end / sets.size
    end
  end
end
