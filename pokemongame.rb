# file for CLI commands
require "tty-prompt"
require_relative 'config/environment.rb'
require_all 'app/models'

prompt = TTY::Prompt.new
# ans = prompt.select('What size?') do |menu|
#     menu.choice 'small', 1
#     menu.choice 'medium', 2, disabled: '(out of stock)'
#     menu.choice 'large', 3
# end
# puts ans

$trainer1 = Trainer.last


# Create Trainer
#Create a new Trainer instance with prompts for name, age, hometown

def trainer_creation
    prompt = TTY::Prompt.new
    puts "Please enter your account information:"
    name = prompt.ask('What is your name?', required: true)
    age = prompt.ask('How old are you?', required: true) #need to limit input to an int
    hometown = prompt.ask('Where are you from?', required: true)
    prompt.ok("Trainer succesfully created. Enjoy the game, #{name}!!!")
    $trainer1 = Trainer.create(name: name, age: age, hometown: hometown)

end


def find_my_trainer
    prompt = TTY::Prompt.new
    puts "Please provide us with the information used to create your trainer:"
    name = prompt.ask('What is your name?', required: true)
    age = prompt.ask('How old are you?', required: true) #need to limit input to an int
    $trainer1 = Trainer.find_by(name: name, age: age)
    if $trainer1
        prompt.ok("Welcome back #{name}!")
        starting_menu
    else
        prompt.error("Sorry, no trainers were found with the information provided.")
        prompt.error("Please try again.")
        begin_game
    end
end

# def choose_starter
#     prompt = TTY::Prompt.new
#     starter = prompt.select("Pick your starter pokemon:", %w(bulbasaur charmander squirtle pikachu))
#     starter_instance = Pokemon.find_by(name: starter)
#     new_name = prompt.ask("What would you like to name your new Pokemon?")
#     CaughtPokemon.create(trainer: $trainer1, pokemon: starter_instance, party: true, name: new_name)
#     prompt.ok("Congratulations! You just took the first step on your journey to become the greatest Pokemon master!")
#     starting_menu
# end

# Now, what would you like to do?
    #Explore the town
    #Catch pokemon
    #View all pokemon
def starting_menu
    prompt = TTY::Prompt.new
    action = prompt.select("What would you like to do?", ["Explore Town", "Catch Pokemon", "View My Pokemon", "View Pokedex", "Exit Game"])
    case action
    when "Explore Town"
        explore
    when "Catch Pokemon"
        catch_pokemon
    when "View My Pokemon"
        view_all_pokemon
    when "View Pokedex"
        pokedex
    else
        abort("Game ended!")
    end
end

#Explore
#Explore - D
    #Professor Oak's Clinic
        #change party pokemon
    #Misty's Gym
        #train pokemon
    #Brock's house
        #learn about how game works
    #Pokemon Center
    #Police station

def explore
    prompt = TTY::Prompt.new
    location = prompt.select("Where would you like to go?", ["Professor Oak's Clinic", "Misty's Gym", "Brock's House", "Pokemon Center", "Police Station", "Go Back"])
    case location
    when "Brock's House"
        brocks_house
    when "Professor Oak's Clinic"
        oaks_clinic
    when "Pokemon Center"
        poke_center
    when "Police Station"
        police
    when "Misty's Gym"
        mistys_gym
    else 
        starting_menu
    end  
end

def party_pokemon(trainer)
    CaughtPokemon.where(trainer: trainer, party: true)
end

def brocks_house
    prompt = TTY::Prompt.new
    prompt.ok("Hey #{$trainer1.name}!!!")
    prompt.ok("Welcome to mi casa}!!!")
    choice = prompt.select("What can I do for you", ["Game Instructions", "Chit Chat", "Leave"])
    case choice
    when "Game Instructions"
        puts "Game Instructions:"
        puts "Party Pokemon"
        puts "How to Catch a Pokemon"
    when "Chit Chat"
        puts "lets chitty chat"
    else
        explore
    end
end

def oaks_clinic #call the change party pokemon method in here
end

def poke_center #view all pokemons
    prompt = TTY::Prompt.new
    pokemons = Pokemon.all.each {|poke| poke.pokemon.name}
    prompt.enum_select("View All Pokemons", pokemons, per_page: 6)

end

def police
end

def mistys_gym
    prompt = TTY::Prompt.new
    choice = prompt.select("What would you like to do?", ["Train my pokemon!", "Talk to Misty", "Go Back"])
        if choice == "Train my pokemon"
            choose_pokemon_to_train
        elsif choice == "Talk to Misty"
            puts "She says hi" #build out?
        else
            explore
        end
    
end


def begin_game
    prompt = TTY::Prompt.new
    choice = prompt.select("", ["Start a new game!", "Continue your game!", "Exit"], active_color: :cyan)
    case choice
    when "Start a new game!"
        trainer_creation
        choose_starter
    when "Continue your game!"
        find_my_trainer
    else
        abort("Game Exited")
    end
end

##pastel.alias_color(:funky, :red, :bold)   need to install gem pastel to use colors
#pastel.funky.on_green('unicorn')   # => will use :red, :bold color


def play_game
    prompt = TTY::Prompt.new
    prompt.say("Welcome to Pokemon World!!!")
    prompt.keypress("Press enter to continue", keys: [:return])
    begin_game
end


def pokedex
    Pokemon.all.each {|pokemon| puts "#{pokemon.id} #{pokemon.name.capitalize}"}
    starting_menu
end

#catch pokemon methods

    def catch_pokemon
        if CaughtPokemon.where(trainer: $trainer1, party: true).count >= 6
            puts "Sorry, you can only catch more pokemon if you have less than 6 pokemon in your party. Please store some with Professor Oak first."
            explore
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
                $ready_to_be_caught = (new_pokemon.capture_rate)/3 +30
                prompt.keypress("Press enter to continue", keys: [:return])
                attempt_catch(new_pokemon)
            else
                puts "Sorry, there are no pokemon here. Maybe try another direction?"
                choose_direction
            end
        end
    end

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
            prompt.keypress("Press enter to continue", keys: [:return])
            choose_direction
        end
    end


    def catch_actions(action, pokemon)
        prompt = TTY::Prompt.new
        if action == "Compliment"
            $ready_to_be_caught += 10
            prompt.ok("The pokemon is flattered!")
            prompt.keypress("Press enter to continue", keys: [:return])
            attempt_catch(pokemon)
        elsif action == "Feed berries"
            $ready_to_be_caught += 20
            prompt.ok("The pokemon loves berries!")
            prompt.keypress("Press enter to continue", keys: [:return])
            attempt_catch(pokemon)
        elsif action == "Taunt"
            $ready_to_be_caught -= 5
            prompt.error("The pokemon did not like that :(")
            prompt.keypress("Press enter to continue", keys: [:return])
            attempt_catch(pokemon)
        elsif action == "Throw pokeball"
            pokeball_throw(pokemon)
        end
    end

    def pokeball_throw(pokemon)
        prompt = TTY::Prompt.new
        prompt.keypress("Pokeball has been thrown... press any key to continue")
        if $ready_to_be_caught >= 70
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
                catch_pokemon
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

#view pokemon methods
    def view_all_pokemon
        prompt = TTY::Prompt.new
        action = prompt.select("What would you like to view?", ["View all pokemon", "View party pokemon", "View pokemon in storage", "Go Back"])
        if action == "View all pokemon"
            $trainer1.view_pokemon
            view_all_pokemon
        elsif action == "View party pokemon"
            $trainer1.view_party_pokemon
            view_all_pokemon
        elsif action == "View pokemon in storage"
            $trainer1.view_storage_pokemon
            view_all_pokemon
        else
            post_catch_actions
        end
    end

#train pokemon methods

def choose_pokemon_to_train
    prompt = TTY::Prompt.new
    party_array = party_pokemon($trainer1).map{|poke| poke.name}
    pokepoke = prompt.select("Which pokemon from your party would you like to train?", party_array)
    train_pokemon(pokepoke)
    if prompt.yes?("Would you like to train another pokemon?")
        choose_pokemon_to_train
    else
        puts "Misty says goodbye and good luck!"
        mistys_gym
    end
end

def train_pokemon(pokemon_name)
    poke = CaughtPokemon.find_by(name: pokemon_name)
    new_level = poke.level +1
    poke.update(level: new_level)
    puts "Congratulations! #{pokemon_name} is now at level #{poke.level}!"
end

    play_game
