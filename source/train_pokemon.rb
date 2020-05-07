require_relative '../config/environment.rb'
prompt = TTY::Prompt.new


def choose_pokemon_to_train
    prompt = TTY::Prompt.new
    print TTY::Box.frame "Train Pokemon", align: :center
    party_array = party_pokemon($trainer1).map{|poke| poke.poke_name}
    if party_array.empty?
        print TTY::Box.error("You don't have any pokemon in your party!")  
        #puts "You don't have any pokemon in your party!"
        mistys_gym
    else
        pokepoke = prompt.enum_select("Which pokemon from your party would you like to train?", party_array, per_page: 5)
        #pokepoke = prompt.select("Which pokemon from your party would you like to train?", party_array)
        train_pokemon(pokepoke)
        choice = prompt.yes?("Would you like to train another pokemon?")
        if choice 
            system "clear"
            choose_pokemon_to_train
        else 
            print TTY::Box.frame "Misty says goodbye and good luck!", align: :center, padding: 1, title: {top_left: "Misty"}
            #prompt.ok("Misty says goodbye and good luck!")
            sleep(2)
            system "clear"
            mistys_gym
        end
    end
end

def train_pokemon(pokemon_name) #level up by 1
    prompt = TTY::Prompt.new
    poke = CaughtPokemon.find_by(poke_name: pokemon_name)
    new_level = ((poke.level) + 1)
    poke.update(level: new_level)
    sleep(1)
    print TTY::Box.success("Congratulations! #{pokemon_name} is now at level #{poke.level}!")
    #prompt.ok("Congratulations! #{pokemon_name} is now at level #{poke.level}!")
end