class CreateJoinTableExerciseBodyPart < ActiveRecord::Migration[5.1]
  def change
    create_join_table :exercises, :body_parts do |t|
      t.index [:exercise_id, :body_part_id]
      t.index [:body_part_id, :exercise_id]
    end
  end
end
