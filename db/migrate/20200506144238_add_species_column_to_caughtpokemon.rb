class AddSpeciesColumnToCaughtpokemon < ActiveRecord::Migration[6.0]
  def change
    add_column :caught_pokemons, :species, :string
  end
end
