# == Schema Information
#
# Table name: routines
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
#  index_routines_on_user_id  (user_id)
#

class Routine < ApplicationRecord
  belongs_to :user
  has_many :routine_exercises, dependent: :destroy
end
