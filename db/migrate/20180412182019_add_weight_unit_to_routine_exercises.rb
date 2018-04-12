class AddWeightUnitToRoutineExercises < ActiveRecord::Migration[5.1]
  def change
    add_column :routine_exercises, :weight_unit, :string
  end
end
