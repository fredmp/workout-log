class RemoveUserFromExercises < ActiveRecord::Migration[5.1]
  def change
    remove_reference :exercises, :user, index: true
  end
end
