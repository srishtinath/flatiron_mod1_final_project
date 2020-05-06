# file for CLI commands
require "tty-prompt"
require_relative 'config/environment.rb'
require_all 'app/models'

prompt = TTY::Prompt.new

# Create Trainer
#Create a new Trainer instance with prompts for name, age, hometown

@@trainer1 = Trainer.last

# @@trainer1 = Trainer.first

def catch_pokemon
    if CaughtPokemon.where(trainer: @@trainer1, party: true).count >= 6
        puts "Sorry, you can only catch more pokemon if you have less than 6 pokemon in your party. Please store some with Professor Oak first."
    else
        go_for_a_walk     
    end
end


def go_for_a_walk
    prompt = TTY::Prompt.new
    decide = prompt.select("What would you like to do?", ["Go for a walk", "Go Back"])
    if decide == "Go for a walk"
        choose_direction
    else
        starting_menu
    end
end

def choose_direction
    prompt = TTY::Prompt.new
    selection = prompt.select("Which direction would you like to go?", ["North", "South", "East", "West", "Go Back"])
    if selection == "Go Back"
        go_for_a_walk
    else
        if rand(100) >= 50 
            new_pokemon = Pokemon.random_pokemon_generator
            $ready_to_be_caught = (new_pokemon.capture_rate)/3 +30
            attempt_catch(new_pokemon)
        else
            puts "Sorry, there are no pokemon here. Maybe try another direction?"
            choose_direction
        end
    end
end

#Attempt to catch or ignore
#Feed, Compliment, Taunt, Throw pokeball
#Caught pokemon
    #Add to party
    #Name pokemon

def attempt_catch(pokemon)
    prompt = TTY::Prompt.new
    attemptCatch = prompt.yes?("Would you like to attempt to catch the pokemon?")
    if attemptCatch
        #Feed, Compliment, Taunt, Throw pokeball
        action = prompt.select("What would you like to do?", ["Feed berries", "Compliment", "Taunt", "Throw pokeball", "Go Back"]) 
        if action == "Go Back"
            choose_direction
        else
            catch_actions(action, pokemon)
        end
    else
        puts "The pokemon ran away to fight another day!"
        choose_direction
    end
end


def catch_actions(action, pokemon)
    if action == "Compliment"
        $ready_to_be_caught += 5
        puts "The pokemon is flattered!"
        attempt_catch(pokemon)
    elsif action == "Feed berries"
        $ready_to_be_caught += 10
        puts "The pokemon loves berries!"
        attempt_catch(pokemon)
    elsif action == "Taunt"
        $ready_to_be_caught -= 5
        puts "The pokemon did not like that :("
        attempt_catch(pokemon)
    elsif action == "Throw pokeball"
        pokeball_throw(pokemon)
        
    end
end

def pokeball_throw(pokemon)
    prompt = TTY::Prompt.new
    if $ready_to_be_caught >= 75
        add_to_caught_pokemon(pokemon)
        puts "#{pokemon.name.capitalize} was caught and added to your party! Congratulations!"
        name = prompt.ask("What would you like to name your new pokemon?")
        pokemon.update(name: name)
        puts "#{name} was added to your party!"
        post_catch_actions
    else
        puts "The pokemon escaped! Try again!"
        attempt_catch(pokemon)  
    end
end

def add_to_caught_pokemon(pokemon)
    poke = CaughtPokemon.create(trainer: @@trainer1, pokemon: pokemon, level: 1, party: true)
    poke
end

def post_catch_actions
    prompt = TTY::Prompt.new
    action = prompt.select("What would you like to do?", ["Catch more pokemon", "View my pokemon", "Go Back"])
    if action == "Catch more pokemon"
        choose_direction
    elsif action == "View my pokemon"
        Trainer.view_pokemon
    else
        go_for_a_walk
    end
end

#view pokemon methods

catch_pokemon
