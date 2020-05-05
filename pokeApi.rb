require_relative 'config/environment.rb'
require 'pry'

##This file is used for filling Pokemon table
def initial_collect
    150.times do |i|
        data = JSON.parse(RestClient.get("https://pokeapi.co/api/v2/pokemon/#{i+1}"))
        count = data["count"]
        newPokemon = Pokemon.create(name:data["name"],xp:data["base_experience"],level:1)
        additional_data = JSON.parse(RestClient.get("https://pokeapi.co/api/v2/pokemon-species/#{i+1}/"))
        newPokemon.update(capture_rate: additional_data["capture_rate"])
        newPokemon.save
        types = data["types"]
        types.length.times do |x|
            newType = types[x]["type"]["name"]
            myType = PokemonType.find_by(name:"#{newType}")
            if(myType)
                newPokemon.pokemon_types<<myType
            else
                newPokemon.pokemon_types<<PokemonType.create(name:"#{newType}")
            end
        end
    end
end