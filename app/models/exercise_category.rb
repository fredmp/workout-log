# == Schema Information
#
# Table name: exercise_categories
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
# Indexes
#
#  index_exercise_categories_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class ExerciseCategory < ApplicationRecord
  belongs_to :user
  has_many :exercises, dependent: :destroy
  validates :name, presence: true
end
