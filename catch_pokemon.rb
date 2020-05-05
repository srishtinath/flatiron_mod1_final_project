require_relative 'config/environment.rb'
require_all 'app/models'

# This file is used for capturing all interaction methods in CLI

#Questions to be answered:
# should any of these be private methods?
# should these methods be a part of a Trainer class instead of its own file?

#ready_to_be_caught variable based on capture_rate (which varies from 0-300). Scaling to 0-100 to make more digestible.
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

def add_to_caught_pokemon(trainer, pokemon)
    Caught_Pokemon.create(trainer: trainer, pokemon: pokemon)
end

def pokemon_caught?(trainer,pokemon)
    if @ready_to_be_caught >= 75
        #yes, it's ready to be caught - add to Caught_Pokemon
        add_to_caught_pokemon(trainer,pokemon)
    else
        puts "The pokemon escaped! Try again!"
    end
end

