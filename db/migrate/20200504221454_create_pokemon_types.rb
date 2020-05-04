class CreatePokemonTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :pokemon_types do |t|
      t.string :name
      t.integer :pokemon_id

    end
  end
end
