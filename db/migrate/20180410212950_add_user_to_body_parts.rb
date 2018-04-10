class AddUserToBodyParts < ActiveRecord::Migration[5.1]
  def change
    add_reference :body_parts, :user, foreign_key: true
  end
end
