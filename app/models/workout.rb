# == Schema Information
#
# Table name: workouts
#
#  id         :integer          not null, primary key
#  date       :datetime
#  duration   :integer
#  comments   :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_workouts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Workout < ApplicationRecord
  belongs_to :user
  has_many :workout_exercises, dependent: :destroy

  validates :date, presence: true

  def build_from_routine(routine)
    return unless routine
    routine.routine_exercises.each do |routine_exercise|
      workout_exercise = self.workout_exercises.build(exercise: routine_exercise.exercise)
      workout_exercise.sets = routine_exercise.sets.map do |set|
        workout_exercise.sets.build(reps: set.reps, weight: set.weight, duration: set.duration)
      end
    end
  end

  def to_s
    I18n.l(date, format: :workout)
  end
end
