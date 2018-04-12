class AddDistanceToExerciseSet < ActiveRecord::Migration[5.1]
  def change
    add_column :exercise_sets, :distance, :decimal
  end
end
