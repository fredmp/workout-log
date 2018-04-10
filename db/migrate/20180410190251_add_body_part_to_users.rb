class AddBodyPartToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :body_part, foreign_key: true
  end
end
