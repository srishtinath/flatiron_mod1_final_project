class CreateCaughtPokemons < ActiveRecord::Migration[6.0]
  def change
    create_table :caught_pokemons do |t|
      t.integer :pokemon_id
      t.integer :trainer_id
    end
  end
end
