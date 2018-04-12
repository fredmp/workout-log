class AddWeightUnitToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :weight_unit, :string
  end
end
