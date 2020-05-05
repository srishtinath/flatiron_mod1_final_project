class AddPartyColumnToCaughtPokemons < ActiveRecord::Migration[6.0]
  def change
    add_column :caught_pokemons, :party, :string
  end
end
