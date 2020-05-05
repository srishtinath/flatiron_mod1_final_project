class Trainer < ActiveRecord::Base
    has_many :caught_pokemons
    has_many :pokemons, through: :caught_pokemons

    #Catch Pokemon methods
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
            generate_number = rand(Pokemon.count)
            @pokemon_encounter = Pokemon.find(generate_number)
            puts "A Wild #{@pokemon_encounter.name} appeared!"
        else
            puts "Sorry, there are no pokemon here. Maybe try a different direction?"
        end
    end
    
        #different actions chosen add to ready_to_be_caught variable
    def attempt_catch(action)
        if action == "Compliment"
            @ready_to_be_caught += 5 
        elsif action == "Feed berries"
            @ready_to_be_caught += 10
        elsif action == "Taunt"
            @ready_to_be_caught -= 5
        end
    end
    
    def add_to_caught_pokemon(pokemon)
        Caught_Pokemon.create(trainer: self, pokemon: pokemon, level: 1)
    end

    def change_pokemon_name(pokemon, name)
        poke = Caught_Pokemon.find_by(id = pokemon.id)
        poke.update(name: name)
        poke.save
        puts "Your pokemon's name has been update to #{name}!"
    end
    
    #throw poke ball method
    
    def pokemon_caught?(pokemon)
        if @ready_to_be_caught >= 75
            add_to_caught_pokemon(pokemon)
        else
            puts "The pokemon escaped! Try again!"
        end
    end

    #View all pokemon belonging to trainer
    def view_pokemon
        Pokemon.all.where(trainer: self)
    end

    def change_party_pokemon

    end

    #train pokemon
    def train(pokemon)
    end

    
end