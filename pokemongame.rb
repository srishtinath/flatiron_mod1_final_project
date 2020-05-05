# file for CLI commands
require "tty-prompt"
require_relative 'config/environment.rb'
require_all 'app/models'

prompt = TTY::Prompt.new

# Create Trainer
    #Create a new Trainer instance with prompts for name, age, hometown

prompt.say("Welcome to Pokemon World!!!")
prompt.keypress("Press enter to continue", keys: [:return])


acct_creation = prompt.yes?('Would you like to create your trainer?')

if acct_creation
    name = prompt.ask('What is your name?')
    age = prompt.ask('How old are you?')
    hometown = prompt.ask('Where are you from?')

    Trainer.create(name: name, age: age, hometown: hometown)
end
name = prompt.ask('What is your name?', default: ENV['USER'])



# Choose Starter Pokemon - S
    #create new instance based on choice offered (Bulbasaur, Charmander, Squirtle, Pikachu)
    
# Now, what would you like to do?
    #Explore the town
    #Catch pokemon
    #View all pokemon

#Explore - D
    #Professor Oak's Clinic
        #change party pokemon
    #Misty's Gym
        #train pokemon
    #Brock's house
        #learn about how game works
    #Pokemon Center
    #Police station

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
