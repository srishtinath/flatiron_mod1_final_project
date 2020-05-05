class ChangePokemonTypesTable < ActiveRecord::Migration[6.0]
  def change
    add_column :pokemon_types, :type_id, :integer
    remove_column :pokemon_types, :name, :string
  end
end
