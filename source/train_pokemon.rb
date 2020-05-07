require_relative '../config/environment.rb'
prompt = TTY::Prompt.new


def choose_pokemon_to_train
    prompt = TTY::Prompt.new
    party_array = party_pokemon($trainer1).map{|poke| poke.name}
    pokepoke = prompt.select("Which pokemon from your party would you like to train?", party_array)
    train_pokemon(pokepoke)
    choice = prompt.yes?("Would you like to train another pokemon?")
    if choice 
        choose_pokemon_to_train
    else 
        prompt.ok("Misty says goodbye and good luck!")
        mistys_gym
    end
end

def train_pokemon(pokemon_name) #level up by 1
    prompt = TTY::Prompt.new
    poke = CaughtPokemon.find_by(name: pokemon_name)
    new_level = ((poke.level) + 1)
    poke.update(level: new_level)
    prompt.ok("Congratulations! #{pokemon_name} is now at level #{poke.level}!")
end