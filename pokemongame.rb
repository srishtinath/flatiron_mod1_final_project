# file for CLI commands
require "tty-prompt"
require_relative 'config/environment.rb'
require_all 'app/models'

prompt = TTY::Prompt.new

# Create Trainer
    #Create a new Trainer instance with prompts for name, age, hometown

prompt.say("Welcome to Pokemon World!!!")
name = prompt.ask('What is your name?', default: ENV['USER'])



# Choose Starter Pokemon
    #create new instance based on choice offered (Bulbasaur, Charmander, Squirtle, Pikachu)

# Now, what would you like to do?
    #Explore the town
    #Catch pokemon
    #View all pokemon

#Explore
    #Professor Oak's Clinic
        #change party pokemon
    #Misty's Gym
        #train pokemon
    #Brock's house
        #learn about how game works
    #Pokemon Center
    #Police station

#Catch Pokemon - what would you like to do?
    #Go for a walk
        #Choose a direction: North, South, East, West
        #Encounter pokemon 
        #Attempt to catch or ignore
            #Feed, Compliment, Taunt, Throw pokeball
            #Caught pokemon
                #Add to party
                #Name pokemon
    #End your walk

#View Pokemon
    #See stats and skills
    #Release into the wild