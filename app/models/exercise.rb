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
#  deleted_at                  :datetime
#
# Indexes
#
#  index_exercises_on_deleted_at            (deleted_at)
#  index_exercises_on_exercise_category_id  (exercise_category_id)
#

class Exercise < ApplicationRecord

  acts_as_paranoid

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

  def in_use_by?(user)
    user.routine_exercises.where(exercise_id: self.id).count > 0 ||
    user.workout_exercises.where(exercise_id: self.id).count > 0
  end

  def destroy
    if exercise_category && in_use_by?(exercise_category.user)
      super
    else
      self.really_destroy!
    end
  end
end
