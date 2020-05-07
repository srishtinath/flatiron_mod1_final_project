require_relative '../config/environment.rb'
prompt = TTY::Prompt.new


def find_my_trainer
    prompt = TTY::Prompt.new
    print TTY::Box.frame "Please provide us with the information used to create your trainer:", padding: 1, align: :center
    name = prompt.ask('What is your name?', required: true)
    age = prompt.ask('How old are you?', required: true) #need to limit input to an int
    trainer_found = Trainer.find_by(name: name, age: age)
    if trainer_found
        $trainer1 = trainer_found
        print TTY::Box.success("Welcome back #{name}!")
        starting_menu
    else
        print TTY::Box.error("Sorry, no trainers were found with the information provided. Please try again.")
        begin_game
    end
end