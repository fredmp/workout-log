class Routine < ApplicationRecord
  has_many :routine_exercises, dependent: :destroy
end
