# == Schema Information
#
# Table name: exercises
#
#  id                          :integer          not null, primary key
#  name                        :string
#  description                 :text
#  exercise_category_id        :integer
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  available_fields_definition :string           default("")
#
# Indexes
#
#  index_exercises_on_exercise_category_id  (exercise_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (exercise_category_id => exercise_categories.id)
#

class Exercise < ApplicationRecord
  belongs_to :exercise_category
  has_and_belongs_to_many :body_parts

  validates :exercise_category, :name, presence: true

  FIELDS = [
    { id: 1, name: 'Reps' },
    { id: 2, name: 'Weight' },
    { id: 3, name: 'Duration' },
    { id: 4, name: 'Distance' }
  ]

  def self.available_fields
    FIELDS.map { |f| OpenStruct.new(f) }
  end

  def available_field_ids
    available_fields_definition.split('-').map { |f| f.to_i }
  end

  def available_field_ids=(field_ids)
    self.available_fields_definition = field_ids.select { |f| f.present? }.join('-')
  end

  def has_field(name)
    field = FIELDS.detect { |f| f[:name].downcase == (name || '').downcase } || {}
    available_fields_definition.include?((field[:id] || '').to_s)
  end
end
