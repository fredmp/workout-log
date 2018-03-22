class CreateWorkouts < ActiveRecord::Migration[5.1]
  def change
    create_table :workouts do |t|
      t.datetime :date
      t.integer :duration
      t.text :comments

      t.timestamps
    end
  end
end
