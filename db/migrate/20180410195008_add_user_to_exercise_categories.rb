class AddUserToExerciseCategories < ActiveRecord::Migration[5.1]
  def change
    add_reference :exercise_categories, :user, foreign_key: true
  end
end
