class CreateRoutines < ActiveRecord::Migration[5.1]
  def change
    create_table :routines do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
