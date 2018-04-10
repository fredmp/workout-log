class RemoveBodyPartFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_reference :users, :body_part, foreign_key: true
  end
end
