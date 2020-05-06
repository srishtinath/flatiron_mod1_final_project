class Trainer < ActiveRecord::Base
    has_many :caught_pokemons
    has_many :pokemons, through: :caught_pokemons

    def change_pokemon_name(pokemon, name)
        poke = CaughtPokemon.find_by(id: pokemon.id)
        poke.update(name: name)
        puts "Your pokemon's name has been updated to #{name}!"
    end

    #View all pokemon belonging to trainer
    def view_pokemon
        CaughtPokemon.all
    end

    def view_party_pokemon
        CaughtPokemon.where(party:true)
    end

    def change_party_pokemon
        CaughtPokemon.all.where(trainer: self)

    end

    def party_full?
        view_party_pokemon.count == 6 ? true : false
    end

    def add_pokemon_to_party(pokemon)
        if party_full?
            puts "You cannot have more than 6 pokemon in your party. First move some to Professor Oak's clinic before adding Pokemon to your party."
        else
            pokemon.party = true
            puts "You have now added #{pokemon.name} to your party!"
        end
    end

    def move_pokemon_to_storage(pokemon)
        pokemon.party = false
        puts "You have now put #{pokemon.name} in storage!"
    end

    #train pokemon
    def train(pokemon)
        poke = CaughtPokemon.find_by(pokemon.id)
        poke.update(level += 1)
        poke.save
    end
    
    #release into wild
    def release(pokemon)
        poke = CaughtPokemon.find_by(pokemon.id)
        poke.update(trainer_id: nil)
    end

end