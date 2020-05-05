class AddColumnsToCaughtPokemons < ActiveRecord::Migration[6.0]
  def change
    add_column :caught_pokemons, :name, :string
    add_column :caught_pokemons, :level, :integer
  end
end
