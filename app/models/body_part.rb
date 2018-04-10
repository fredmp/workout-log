# == Schema Information
#
# Table name: body_parts
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_body_parts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class BodyPart < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :exercises

  validates :name, presence: true
end
