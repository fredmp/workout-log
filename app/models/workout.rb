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
#

class Workout < ApplicationRecord
  has_many :workout_exercises, dependent: :destroy
end
