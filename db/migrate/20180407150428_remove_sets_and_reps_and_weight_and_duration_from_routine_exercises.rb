class RemoveSetsAndRepsAndWeightAndDurationFromRoutineExercises < ActiveRecord::Migration[5.1]
  def change
    remove_column :routine_exercises, :sets, :integer
    remove_column :routine_exercises, :reps, :integer
    remove_column :routine_exercises, :weight, :decimal
    remove_column :routine_exercises, :duration, :integer
  end
end
