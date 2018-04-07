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
#
# Indexes
#
#  index_exercise_sets_on_setable_type_and_setable_id  (setable_type,setable_id)
#

class ExerciseSet < ApplicationRecord
  belongs_to :setable, polymorphic: true
end
