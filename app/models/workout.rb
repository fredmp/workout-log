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
      self.workout_exercises.build(
        exercise: routine_exercise.exercise,
        sets: routine_exercise.sets,
        reps: routine_exercise.reps,
        weight: routine_exercise.weight,
        duration: routine_exercise.duration,
      )
    end
  end

  def to_s
    date.strftime('%a - %b %d, %Y - %H:%M')
  end
end
