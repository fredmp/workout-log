class AddDeletedAtToExercises < ActiveRecord::Migration[5.1]
  def change
    add_column :exercises, :deleted_at, :datetime
    add_index :exercises, :deleted_at
  end
end
