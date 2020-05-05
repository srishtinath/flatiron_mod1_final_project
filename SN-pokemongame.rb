# file for CLI commands
require "tty-prompt"
require_relative 'config/environment.rb'
require_all 'app/models'
require_relative 'pokemongame'

prompt = TTY::Prompt.new


#Catch Pokemon - what would you like to do? - S
    #Go for a walk
        #Choose a direction: North, South, East, West
        #Encounter pokemon 

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
        if @@trainer1.encounter_pokemon?
            new_pokemon = @@trainer1.random_pokemon_generator
            catch_pokemon(new_pokemon)
            prompt.yes?("Would you like to catch another pokemon?") ? choose_direction : go_for_a_walk
        else
            puts "Sorry, there are no pokemon here. Try a different direction."
            choose_direction
        end
    end
end
    
#Attempt to catch or ignore
    #Feed, Compliment, Taunt, Throw pokeball
    #Caught pokemon
        #Add to party
        #Name pokemon

def catch_pokemon(pokemon)
    prompt = TTY::Prompt.new
    attemptCatch = prompt.yes?("Would you like to attempt to catch the pokemon?")
    if attemptCatch
        #Feed, Compliment, Taunt, Throw pokeball
        action = prompt.select("What would you like to do?", ["Feed", "Compliment", "Taunt", "Throw pokeball", "Go Back"]) 
        if action == "Go Back"
            choose_direction
        else
            @@trainer1.attempt_catch(self, @pokemon_encounter)
        end
        #Caught pokemon
            #Add to party
            #Name pokemon
    else
        choose_direction
    end
end

starting_menu
go_for_a_walk
catch_pokemon

        

#View Pokemon - S
    #See stats and skills
    #Release into the wild
