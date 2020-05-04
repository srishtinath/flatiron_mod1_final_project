class Pokemon < ActiveRecord::Base
    has_many :caught_pokemons
    has_many :pokemon_types
    has_many :trainers, through: :caught_pokemons
end