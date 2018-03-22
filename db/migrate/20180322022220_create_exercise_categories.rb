class CreateExerciseCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :exercise_categories do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
