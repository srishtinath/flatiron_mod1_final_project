class Trainer < ActiveRecord::Base
    has_many :caught_pokemons
    has_many :pokemons, through: :caught_pokemons

    prompt = TTY::Prompt.new

    def capture_rate(pokemon)
        @ready_to_be_caught = (pokemon.capture_rate)/3
    end
    
        #allows for 50/50 chance of an encounter
    def encounter_pokemon? 
        random_number = rand(100)
        random_number >= 50 ? true : false
    end
    
        # generates pokemon if encounter_pokemon is true
    def random_pokemon_generator  
        if encounter_pokemon?
            generate_number = rand(0..150)
            @pokemon_encounter = Pokemon.find(generate_number)
            puts "A Wild #{@pokemon_encounter.name} appeared!"
        else
            puts "Sorry, there are no pokemon here. Maybe try a different direction?"
        end
    end
    
        #different actions chosen add to ready_to_be_caught variable
    def attempt_catch(action, pokemon)
        if action == "Compliment"
            @ready_to_be_caught += 5
            puts "The pokemon is flattered!"
        elsif action == "Feed berries"
            @ready_to_be_caught += 10
            puts "The pokemon loves berries!"
        elsif action == "Taunt"
            @ready_to_be_caught -= 5
            puts "The pokemon did not like that :("
        elsif action == "Throw pokeball"
            if @ready_to_be_caught >= 75
                add_to_caught_pokemon(pokemon)
                puts "#{pokemon.name} was caught and added to your party! Congratulations!"
            else
                puts "The pokemon escaped! Try again!"   
            end
        end
    end
    

    def add_to_caught_pokemon(pokemon)
        CaughtPokemon.create(trainer: self, pokemon: pokemon, level: 1, party: true)
    end
<<<<<<< HEAD
    
    #throw poke ball method
    
    def pokemon_caught?(pokemon)
        if @ready_to_be_caught >= 75
            add_to_caught_pokemon(pokemon)
        else
            puts "The pokemon escaped! Try again!"
        end
=======

    def change_pokemon_name(pokemon, name)
        poke = CaughtPokemon.find_by(id: pokemon.id)
        poke.update(name: name)
        puts "Your pokemon's name has been updated to #{name}!"
>>>>>>> 0522be6a0b68daafa306ae62b607bd9c4e6aa8bc
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