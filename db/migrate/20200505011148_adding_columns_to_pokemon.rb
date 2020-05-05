class AddingColumnsToPokemon < ActiveRecord::Migration[6.0]
  def change
    add_column :pokemons, :back_img_url, :string
    add_column :pokemons, :front_img_url, :string
  end
end
