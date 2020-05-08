class Pokemon < ActiveRecord::Base
    has_many :caught_pokemons
    has_many :pokemon_types
    has_many :types, through: :pokemon_types
    has_many :trainers, through: :caught_pokemons

    def self.random_pokemon_generator
        number = Pokemon.count
        pokemon_generated = Pokemon.find_by(id:rand(1..number))
        pokemon_generated
    end




end