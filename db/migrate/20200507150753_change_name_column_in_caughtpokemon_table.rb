class ChangeNameColumnInCaughtpokemonTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :caught_pokemons, :name, :poke_name
  end
end
