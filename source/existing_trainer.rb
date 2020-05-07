require_relative '../config/environment.rb'
prompt = TTY::Prompt.new


def find_my_trainer
    prompt = TTY::Prompt.new
    puts "Please provide us with the information used to create your trainer:"
    name = prompt.ask('What is your name?', required: true)
    age = prompt.ask('How old are you?', required: true) #need to limit input to an int
    trainer_found = Trainer.find_by(name: name, age: age)
    if trainer_found
        $trainer1 = trainer_found
        prompt.ok("Welcome back #{name}!")
        starting_menu
    else
        prompt.error("Sorry, no trainers were found with the information provided.")
        prompt.error("Please try again.")
        begin_game
    end
end