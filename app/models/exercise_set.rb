# == Schema Information
#
# Table name: exercise_sets
#
#  id           :integer          not null, primary key
#  setable_type :string
#  setable_id   :integer
#  reps         :integer
#  weight       :decimal(, )
#  duration     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  distance     :decimal(, )
#
# Indexes
#
#  index_exercise_sets_on_setable_type_and_setable_id  (setable_type,setable_id)
#

class ExerciseSet < ApplicationRecord
  belongs_to :setable, polymorphic: true

  validate :any_present?

  def to_s
    result = []
    result << "Reps: #{reps}" if setable.exercise.has_field('reps') && reps
    result << "Weight: #{weight}" if setable.exercise.has_field('weight') && weight
    result << "Duration: #{duration}" if setable.exercise.has_field('duration') && duration
    return result.join(' - ')
  end

  private

  def any_present?
    if %w(reps weight duration).all? { |attribute| self[attribute].blank? }
      errors.add :base, 'At least one field must be present'
    end
  end
end
