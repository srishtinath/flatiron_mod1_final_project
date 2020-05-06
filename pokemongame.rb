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

@@trainer1 = Trainer.last






# Create Trainer
#Create a new Trainer instance with prompts for name, age, hometown

def trainer_creation
    prompt = TTY::Prompt.new
    puts "Please enter your account information:"
    name = prompt.ask('What is your name?', required: true)
    age = prompt.ask('How old are you?', required: true) #need to limit input to an int
    hometown = prompt.ask('Where are you from?', required: true)
    prompt.ok("Trainer succesfully created. Enjoy the game, #{name}!!!")
    @@trainer1 = Trainer.create(name: name, age: age, hometown: hometown)
end


def find_my_trainer
    prompt = TTY::Prompt.new
    puts "Please provide us with the information used to create your trainer:"
    name = prompt.ask('What is your name?', required: true)
    age = prompt.ask('How old are you?', required: true) #need to limit input to an int
    trainer_found = Trainer.find_by(name: name, age: age)
    if trainer_found
        prompt.ok("Welcome back #{name}!")
        starting_menu
    else
        prompt.error("Sorry, no trainers were found with the information provided.")
        prompt.error("Please try again.")
        begin_game
    end
end

def choose_starter
    prompt = TTY::Prompt.new
    starter = prompt.select("Pick your starter pokemon:", %w(Bulbasaur Charmander Squirtle Pikachu))
    starter_instance = Pokemon.find_by(name: starter)
    new_name = prompt.ask("What would you like to name your new Pokemon?")
    CaughtPokemon.create(pokemon: starter_instance, party: true, name: new_name)
    prompt.ok("Congratulations! You just took the first step on your journey to become the greatest Pokemon master!")
    starting_menu
end

# Now, what would you like to do?
    #Explore the town
    #Catch pokemon
    #View all pokemon
def starting_menu
    prompt = TTY::Prompt.new
    action = prompt.select("What would you like to do?", ["Explore Town", "Catch Pokemon", "View My Pokemons", "View All Pokemons", "Exit Game"])
    case action
    when "Explore Town"
        explore
    when "Catch Pokemon"
        puts "Catch Pokemon"
    when "View My Pokemons"
        puts "My Pokemons"
    when "View All Pokemons"
        puts "All pokemons"
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
        puts "Brock man"
    when "Professor Oak's Clinic"
        puts "Oaky"
    when "Pokemon Center"
        puts "Center"
    when "Police Station"
        puts "Policia"
    when "Misty's Gym"
        puts "Misty"
    else 
        starting_menu
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

play_game
