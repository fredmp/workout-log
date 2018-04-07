class CreateExerciseSets < ActiveRecord::Migration[5.1]
  def change
    create_table :exercise_sets do |t|
      t.references :setable, polymorphic: true, index: true
      t.integer :reps
      t.decimal :weight
      t.integer :duration

      t.timestamps
    end
  end
end
