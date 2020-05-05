# file for CLI commands
require "tty-prompt"
require_relative 'config/environment.rb'
require_all 'app/models'

prompt = TTY::Prompt.new

prompt.say("Welcome to Pokemon World!!!")
prompt.keypress("Press enter to continue", keys: [:return])

# Create Trainer
#Create a new Trainer instance with prompts for name, age, hometown

def trainer_creation
    prompt = TTY::Prompt.new
    acct_creation = prompt.yes?('Would you like to create your trainer?') #Need to create a Trainer instance to make other methods work
    if acct_creation
        name = prompt.ask('What is your name?', required: true)
        age = prompt.ask('How old are you?', required: true) #need to limit input to an int
        hometown = prompt.ask('Where are you from?', required: true)
    
        @@trainer1 = Trainer.create(name: name, age: age, hometown: hometown)
    end

end

# Choose Starter Pokemon - S
    #create new instance based on choice offered (Bulbasaur, Charmander, Squirtle, Pikachu)

def starter_pokemon
    prompt = TTY::Prompt.new

    starter_pokemon = prompt.select("Select your starter pokemon:", ["Pikachu", "Charmander", "Squirtle", "Bulbasaur"])
    #add to the caught_pokemon table
   # pokemon = Pokemon.find_by(name: pokemon)
    #add_to_caught_pokemon(pokemon)
end

def choose_starter
    prompt = TTY::Prompt.new
    starter = prompt.select("Which starter pokemon would you like to choose?", %w(bulbasaur charmander squirtle pikachu))
    starter_instance = Pokemon.find_by(name: starter)
    new_name = prompt.ask("What would you like to name your new Pokemon?")
    CaughtPokemon.create(pokemon: starter_instance, party: true, name: new_name)
    puts "Congratulations! You just took the first step on your journey to become the greatest Pokemon master!"
end

# Now, what would you like to do?
    #Explore the town
    #Catch pokemon
    #View all pokemon
def starting_menu
    prompt = TTY::Prompt.new

    action = prompt.select("What would you like to do?", ["Explore Town", "Catch Pokemon", "View My Pokemons", "Exit Game"])
    case action
    when "Explore Town"
        explore
    when "Catch Pokemon"
        puts "Catch Pokemon"
    when "View My Pokemons"
        puts "My Pokemons"
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


trainer_creation
starter_pokemon
starting_menu