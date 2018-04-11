class AddAvailableFieldsDefinitionToExercises < ActiveRecord::Migration[5.1]
  def change
    add_column :exercises, :available_fields_definition, :string, default: ''
  end
end
