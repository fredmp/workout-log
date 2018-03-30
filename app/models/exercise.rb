class Exercise < ApplicationRecord
  belongs_to :exercise_category

  validates :exercise_category, :name, presence: true
end
