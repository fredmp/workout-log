# == Schema Information
#
# Table name: exercises
#
#  id                   :integer          not null, primary key
#  name                 :string
#  description          :text
#  exercise_category_id :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_exercises_on_exercise_category_id  (exercise_category_id)
#

class Exercise < ApplicationRecord
  belongs_to :exercise_category
  has_and_belongs_to_many :body_parts

  validates :exercise_category, :name, presence: true
end
