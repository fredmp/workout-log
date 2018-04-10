# == Schema Information
#
# Table name: body_parts
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BodyPart < ApplicationRecord
  has_and_belongs_to_many :exercises

  validates :name, presence: true
end
