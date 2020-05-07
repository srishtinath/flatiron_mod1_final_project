require_relative '../config/environment.rb'
prompt = TTY::Prompt.new


def trainer_creation
    prompt = TTY::Prompt.new
    print TTY::Box.frame "Please enter your account information:", padding: 1, align: :center
    name = prompt.ask('What is your name?', required: true)
    age = prompt.ask('How old are you?', required: true)
    hometown = prompt.ask('Where are you from?', required: true)
    print TTY::Box.success("Trainer succesfully created. Enjoy the game, #{name}!!!", padding: 1, align: :center)
    $trainer1 = Trainer.create(name: name, age: age, hometown: hometown)
end

def choose_starter
    prompt = TTY::Prompt.new
    system "clear"
    display_starters
    starter = prompt.select("Pick your starter pokemon:", %w(Bulbasaur Charmander Squirtle Pikachu))
    starter_instance = Pokemon.find_by(name: starter.downcase)
    new_name = prompt.ask("What would you like to name your new Pokemon?")
    CaughtPokemon.create(pokemon: starter_instance, party: true, poke_name: new_name, level: 1, trainer: $trainer1)
    print TTY::Box.success("Congratulations! You just took the first step on your journey to become the greatest Pokemon master!")
    starting_menu
end