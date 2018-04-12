class AddWeightUnitToWorkoutExercises < ActiveRecord::Migration[5.1]
  def change
    add_column :workout_exercises, :weight_unit, :string
  end
end
