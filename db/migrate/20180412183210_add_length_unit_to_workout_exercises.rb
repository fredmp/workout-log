class AddLengthUnitToWorkoutExercises < ActiveRecord::Migration[5.1]
  def change
    add_column :workout_exercises, :length_unit, :string
  end
end
