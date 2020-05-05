require "tty-prompt"
require_relative 'config/environment.rb'
require_all 'app/models'

prompt = TTY::Prompt.new
# Choose Starter Pokemon - S
    #create new instance based on choice offered (Bulbasaur, Charmander, Squirtle, Pikachu)
def choose_starter
    
    starter = prompt.select("Which starter pokemon would you like to choose?", %w(bulbasaur charmander squirtle pikachu))
    starter_instance = Pokemon.find_by(name: starter)
    new_name = prompt.ask("What would you like to name your new Pokemon?")
    CaughtPokemon.create(pokemon: starter_instance, party: true, name: new_name)
    puts "Congratulations! You just took the first step on your journey to become the greatest Pokemon master!"
end

#Catch Pokemon - what would you like to do? - S

    #Go for a walk
        #Choose a direction: North, South, East, West
        #Encounter pokemon 

    def choose_direction
        prompt.select("Which direction would you like to go?", %w(North South East West))
        if Trainer.encounter_pokemon?
            Trainer.random_pokemon_generator
            Trainer.catch_pokemon
            prompt.yes?("Would you like to catch another pokemon?") ? Trainer.choose_direction : Trainer.walk
        else
            puts "Sorry, there are no pokemon here. Try a different direction."
            Trainer.choose_direction
        end
    end

    choose_direction

        #Attempt to catch or ignore
        def catch_pokemon
            attemptCatch = prompt.yes?("Would you like to catch the pokemon?")
            if attemptCatch
                #Feed, Compliment, Taunt, Throw pokeball
                action = prompt.select("What would you like to do?") do |menu|
                    menu.choice 'Feed', 1
                    menu.choice 'Compliment', 2
                    menu.choice 'Taunt', 3
                    menu.choice 'Throw pokeball', 4
                end
                Trainer.first.attempt_catch(self, @pokemon_encounter)
                #Caught pokemon
                    #Add to party
                    #Name pokemon
            end
        end
    #End your walk

#View Pokemon - S
    #See stats and skills
    #Release into the wild

    