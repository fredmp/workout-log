class CreateWorkoutExercises < ActiveRecord::Migration[5.1]
  def change
    create_table :workout_exercises do |t|
      t.references :exercise, foreign_key: true
      t.references :workout, foreign_key: true
      t.integer :sets
      t.integer :reps
      t.decimal :weight
      t.integer :duration

      t.timestamps
    end
  end
end
