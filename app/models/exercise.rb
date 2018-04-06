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
#  user_id              :integer
#
# Indexes
#
#  index_exercises_on_exercise_category_id  (exercise_category_id)
#  index_exercises_on_user_id               (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (exercise_category_id => exercise_categories.id)
#  fk_rails_...  (user_id => users.id)
#

class Exercise < ApplicationRecord
  belongs_to :user
  belongs_to :exercise_category

  validates :exercise_category, :name, presence: true
end
