require "tty-prompt"
require_relative 'config/environment.rb'
require_all 'app/models'

prompt = TTY::Prompt.new


prompt.say("Welcome to Pokemon World!!!")
prompt.keypress("Press enter to continue", keys: [:return])


acct_creation = prompt.yes?('Would you like to create your trainer?')

if acct_creation
    name = prompt.ask('What is your name?')
    age = prompt.ask('How old are you?')
    hometown = prompt.ask('Where are you from?')

    Trainer.create(name: name, age: age, hometown: hometown)
end