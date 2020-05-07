require_relative '../config/environment.rb'
prompt = TTY::Prompt.new


def catch_pokemon
    if CaughtPokemon.where(trainer: $trainer1, party: true).count >= 6
        puts "Sorry, you can only catch more pokemon if you have less than 6 pokemon in your party. Please store some with Professor Oak first."
    else
        go_for_a_walk     
    end
end


def go_for_a_walk
    prompt = TTY::Prompt.new
    decide = prompt.select("What would you like to do?", ["Go for a walk", "View all my pokemon", "Go Back"])
    if decide == "Go for a walk"
        choose_direction
    elsif decide == "View all my pokemon"
        view_all_pokemon
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
            $ready_to_be_caught = (new_pokemon.capture_rate)/3 + 30
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
        action = prompt.select("What would you like to do?", ["Feed berries", "Compliment", "Taunt", "Throw pokeball", "Go Back"], active_color: :cyan) 
        if action == "Go Back"
            choose_direction
        else
            catch_actions(action, pokemon)
        end
    else
        prompt.ok("The pokemon ran away to fight another day!")
        choose_direction
    end
end
def catch_actions(action, pokemon)
    prompt = TTY::Prompt.new
    if action == "Compliment"
        $ready_to_be_caught += 10
        prompt.ok("The pokemon is flattered!")
        attempt_catch(pokemon)
    elsif action == "Feed berries"
        $ready_to_be_caught += 20
        prompt.ok("The pokemon loves berries!")
        attempt_catch(pokemon)
    elsif action == "Taunt"
        $ready_to_be_caught -= 5
        prompt.error("The pokemon did not like that :(")
        attempt_catch(pokemon)
    elsif action == "Throw pokeball"
        pokeball_throw(pokemon)
        
    end
end

def pokeball_throw(pokemon)
    prompt = TTY::Prompt.new
    if $ready_to_be_caught >= 60
        new_instance = add_to_caught_pokemon(pokemon)
        prompt.ok("#{pokemon.name.capitalize} was caught and added to your party! Congratulations!")
        name = prompt.ask("What would you like to name your new pokemon?")
        new_instance.update(name: name)
        prompt.ok("#{name} was added to your party!")
        post_catch_actions
    else
        prompt.error("The pokemon escaped from the pokeball! Try again!")
        attempt_catch(pokemon)  
    end
end


def add_to_caught_pokemon(pokemon)
    poke = CaughtPokemon.create(trainer: $trainer1, pokemon: pokemon, level: 1, party: true)
    poke
end

def post_catch_actions
    prompt = TTY::Prompt.new
    action = prompt.select("What would you like to do?", ["Catch more pokemon", "View my pokemon", "Go Back", "Exit Game"])
    if action == "Catch more pokemon"
        if CaughtPokemon.where(trainer: $trainer1, party: true).count >= 6
            puts "Your party is full! Please put some in storage with Professor Oak before catching more pokemon!"
        else 
            choose_direction
        end
    elsif action == "View my pokemon"
        view_all_pokemon
    elsif action == "Exit Game"
        abort("Game ended!")
    else
        go_for_a_walk
    end
end