# file for CLI commands
require "tty-prompt"
require_relative 'config/environment.rb'
require_all 'app/models'

prompt = TTY::Prompt.new

prompt.say("Welcome to Pokemon World!!!")
prompt.keypress("Press enter to continue", keys: [:return])

# Create Trainer
#Create a new Trainer instance with prompts for name, age, hometown
acct_creation = prompt.yes?('Would you like to create your trainer?')

if acct_creation
    name = prompt.ask('What is your name?', required: true)
    age = prompt.ask('How old are you?', required: true)
    hometown = prompt.ask('Where are you from?', required: true)

    #Trainer.create(name: name, age: age, hometown: hometown)
end
<<<<<<< HEAD
=======
name = prompt.ask('What is your name?', default: ENV['USER'])
>>>>>>> 22a3827d9d569dfc8d1da7e70febe83c20c3e13d



# Choose Starter Pokemon - S
    #create new instance based on choice offered (Bulbasaur, Charmander, Squirtle, Pikachu)

pokemon = prompt.select("Select your starter pokemon:", ["Pikachu", "Charmander", "Squirtle", "Bulbasaur"])


# Now, what would you like to do?
    #Explore the town
    #Catch pokemon
    #View all pokemon

<<<<<<< HEAD
action = prompt.select("What would you like to do?", ["Explore Town", "Catch Pokemon", "View My Pokemons"])



#Explore
=======
#Explore - D
>>>>>>> 22a3827d9d569dfc8d1da7e70febe83c20c3e13d
    #Professor Oak's Clinic
        #change party pokemon
    #Misty's Gym
        #train pokemon
    #Brock's house
        #learn about how game works
    #Pokemon Center
    #Police station
    
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
    location = prompt.select("Where would you like to go?", ["Professor Oak's Clinic", "Misty's Gym", "Brock's House", "Pokemon Center", "Police Station", "Go Back"])
end





#Catch Pokemon - what would you like to do? - S
    #Go for a walk
        #Choose a direction: North, South, East, West
        #Encounter pokemon 
        #Attempt to catch or ignore
            #Feed, Compliment, Taunt, Throw pokeball
            #Caught pokemon
                #Add to party
                #Name pokemon
    #End your walk

#View Pokemon - S
    #See stats and skills
    #Release into the wild
