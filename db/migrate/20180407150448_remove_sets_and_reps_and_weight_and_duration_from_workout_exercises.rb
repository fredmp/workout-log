class RemoveSetsAndRepsAndWeightAndDurationFromWorkoutExercises < ActiveRecord::Migration[5.1]
  def change
    remove_column :workout_exercises, :sets, :integer
    remove_column :workout_exercises, :reps, :integer
    remove_column :workout_exercises, :weight, :decimal
    remove_column :workout_exercises, :duration, :integer
  end
end
