class AddLengthUnitToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :length_unit, :string
  end
end
