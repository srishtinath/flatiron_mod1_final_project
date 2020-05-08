require_relative '../config/environment.rb'
prompt = TTY::Prompt.new


def catch_pokemon
    if CaughtPokemon.where(trainer:$trainer1).size == 10
        win_game
        system "clear"
        starting_menu
    elsif CaughtPokemon.where(trainer: $trainer1, party: true).count >= 6
        sleep(1)
        print TTY::Box.error("Sorry, you can only catch more pokemon if you have less than 6 pokemon in your party. Please store some with Professor Oak first.")
        sleep(3)
        system "clear"
        starting_menu
    else
        system "clear"
        go_for_a_walk     
    end
end

def go_for_a_walk
    prompt = TTY::Prompt.new
    print TTY::Box.frame "Catch Pokemon", align: :center

    decide = prompt.select("What would you like to do?", ["Go for a walk", "View all my pokemon", "Go Back"])
    if decide == "Go for a walk"
        system "clear"
        choose_direction
    elsif decide == "View all my pokemon"
        system "clear"
        view_all_pokemon
    else
        system "clear"
        starting_menu
    end
end

def choose_direction
    prompt = TTY::Prompt.new
    print TTY::Box.frame "Go for a walk", align: :center
    selection = prompt.select("Which direction would you like to go?", ["North", "South", "East", "West", "Go Back"])
    if selection == "Go Back"
        system "clear"
        go_for_a_walk
    else
        if rand(100) >= 50 
            new_pokemon = Pokemon.random_pokemon_generator
            $ready_to_be_caught = (new_pokemon.capture_rate)/3 + 30
            attempt_catch(new_pokemon)
        else
            prompt.error("Sorry, there are no pokemon here. Maybe try another direction?")
            sleep(2)
            system "clear"
            choose_direction
        end
    end
end


def attempt_catch(pokemon)
    prompt = TTY::Prompt.new
    display_trainer_and_pokemon(pokemon)
    attemptCatch = prompt.yes?("Would you like to attempt to catch the pokemon?")
    if attemptCatch
        #Feed, Compliment, Taunt, Throw pokeball
        system "clear"
        display_trainer_and_pokemon(pokemon)
        print TTY::Box.frame "Attempt Catch", align: :center
        action = prompt.select("What would you like to do?", ["Feed berries", "Compliment", "Taunt", "Throw pokeball", "Go Back"], active_color: :cyan) 
        if action == "Go Back"
            system "clear"
            choose_direction
        else
            system "clear"
            catch_actions(action, pokemon)
        end
    else
        print TTY::Box.error("The pokemon ran away to fight another day!")
        sleep(2)
        system "clear"
        choose_direction
    end
end
def catch_actions(action, pokemon)
    prompt = TTY::Prompt.new
    display_trainer_and_pokemon(pokemon)

    print TTY::Box.frame "Attempt Catch", align: :center

    if action == "Compliment"
        $ready_to_be_caught += 10
        print TTY::Box.info("The pokemon is flattered!")
        #prompt.ok("The pokemon is flattered!")
        sleep(2)
        system "clear"
        attempt_catch(pokemon)
    elsif action == "Feed berries"
        $ready_to_be_caught += 20
        print TTY::Box.info("The pokemon loves berries!")
        #prompt.ok("The pokemon loves berries!")
        sleep(2)
        system "clear"
        attempt_catch(pokemon)

    elsif action == "Taunt"
        $ready_to_be_caught -= 5
        print TTY::Box.warn("The pokemon did not like that :(")
        #prompt.error("The pokemon did not like that :(")
        sleep(2)
        system "clear"
        attempt_catch(pokemon)

    elsif action == "Throw pokeball"
        system "clear"
        pokeball_throw(pokemon)
    end
end

def pokeball_throw(pokemon)
    prompt = TTY::Prompt.new

    print TTY::Box.frame "Attempt Catch", align: :center

    if $ready_to_be_caught >= 70
        display_one(pokemon)
        new_instance = add_to_caught_pokemon(pokemon)
        print TTY::Box.success("#{pokemon.name.capitalize} was caught and added to your party! Congratulations!")
        name = prompt.ask("What would you like to name your new pokemon?", required:true)
        new_instance.update(poke_name: name)
        print TTY::Box.success("#{name} was added to your party!")
        sleep(2)
        system "clear"
        post_catch_actions
    else
        display_trainer_and_pokemon(pokemon)
        print TTY::Box.error("The pokemon escaped from the pokeball! Try again!")
        sleep(2)
        system "clear"
        attempt_catch(pokemon)  
    end
end


def add_to_caught_pokemon(pokemon)
    poke = CaughtPokemon.create(trainer: $trainer1, pokemon: pokemon, level: 1, party: true)
    poke
end

def post_catch_actions
    prompt = TTY::Prompt.new
    print TTY::Box.frame "Go for a walk", align: :center

    if CaughtPokemon.where(trainer:$trainer1).size == 10
        win_game
        starting_menu
    else
        action = prompt.select("What would you like to do?", ["Catch more pokemon", "View my pokemon", "Go Back", "Exit Game"])
        if action == "Catch more pokemon"
            if CaughtPokemon.where(trainer: $trainer1, party: true).count >= 6
                print TTY::Box.error("Your party is full! Please put some in storage with Professor Oak before catching more pokemon!")
                system "clear"
                starting_menu
            else
                system "clear" 
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
end