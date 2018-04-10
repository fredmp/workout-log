class AddExerciseCategoryToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :exercise_category, foreign_key: true
  end
end
