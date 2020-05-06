class DeleteSpeciesColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :caught_pokemons, :species 
  end
end
