class AddLengthUnitToRoutineExercises < ActiveRecord::Migration[5.1]
  def change
    add_column :routine_exercises, :length_unit, :string
  end
end
