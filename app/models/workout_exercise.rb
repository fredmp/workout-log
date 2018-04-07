# == Schema Information
#
# Table name: workout_exercises
#
#  id          :integer          not null, primary key
#  exercise_id :integer
#  workout_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_workout_exercises_on_exercise_id  (exercise_id)
#  index_workout_exercises_on_workout_id   (workout_id)
#
# Foreign Keys
#
#  fk_rails_...  (exercise_id => exercises.id)
#  fk_rails_...  (workout_id => workouts.id)
#

class WorkoutExercise < ApplicationRecord
  belongs_to :exercise
  belongs_to :workout

  has_many :exercise_sets, as: :setable, dependent: :destroy, inverse_of: :setable

  accepts_nested_attributes_for :exercise_sets, reject_if: :all_blank, allow_destroy: true

  alias_attribute :sets, :exercise_sets

  %w(reps weight duration).each do |name|
    define_method(name.to_sym) do
      return 0 if sets.empty?
      total = sets.reduce(0) do |accumulator, current|
        accumulator + (current.send(name.to_sym) || 0)
      end
      total > 0 ? total / sets.size : 0
    end
  end
end
