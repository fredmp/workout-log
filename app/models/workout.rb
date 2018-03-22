class Workout < ApplicationRecord
  has_many :workout_exercises, dependent: :destroy
end
