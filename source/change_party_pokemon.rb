require_relative '../config/environment.rb'
prompt = TTY::Prompt.new



def change_party_pokemon
    prompt = TTY::Prompt.new
    choice = prompt.select("What would you like to do?", ["Remove pokemon from party", "Add pokemon to party", "Change pokemon name", "Release pokemon to wild", "Go Back"])
        if choice == "Remove pokemon from party"
            remove_pokemon_from_party
        elsif choice == "Add pokemon to party"
            add_pokemon_to_party
            oaks_clinic
        elsif choice == "Change pokemon name"
            change_pokemon_name
            oaks_clinic
        elsif choice == "Release pokemon to wild"
            release_pokemon
            oaks_clinic
        else
            oaks_clinic
        end
end

def remove_pokemon_from_party
    prompt = TTY::Prompt.new
    party_array = party_pokemon($trainer1).map{|poke| poke.name}
    pokepoke = prompt.select("Which pokemon would you like to remove from your party?", party_array)
    chosen_one = CaughtPokemon.where(name: pokepoke, trainer: $trainer1)
    chosen_one.update(party: false)
    puts "#{chosen_one.name} has been moved to storage!"
    change_party_pokemon
end


def add_pokemon_to_party
    prompt = TTY::Prompt.new
    if $trainer1.party_full?
        puts "Your party is full. Please move some to storage first."
        change_party_pokemon
    else
        party_array = party_pokemon($trainer1).map{|poke| poke.name}
        pokepoke = prompt.select("Which pokemon would you like to remove from your party?", party_array)
        chosen_one = CaughtPokemon.where(name: pokepoke, trainer: $trainer1)
        chosen_one.update(party: true)
        puts "#{chosen_one.name} has been moved to storage!"
        add_pokemon_to_party
    end
end

def change_pokemon_name
    prompt = TTY::Prompt.new
    party_array = CaughtPokemon.where(trainer:$trainer1).map{|poke| poke.name}
    pokepoke = prompt.select("Which pokemon's name would you like to change?", party_array)
    new_name = prompt.ask("What would you like to change it to?")
    poke_to_change = CaughtPokemon.find_by(name: pokepoke, trainer: $trainer1)
    poke_to_change.update(name: new_name)
    puts "Your pokemon's name has been changed to #{poke_to_change.name}!"
    change_party_pokemon
end

def release_pokemon
    prompt = TTY::Prompt.new
    party_array = CaughtPokemon.where(trainer:$trainer1).map{|poke| poke.name}
    pokepoke = prompt.select("Which pokemon would you like to release into the wild unknown?", party_array)
    sure = prompt.yes?("Are you sure you want to release #{pokepoke}?")
    if sure
        poke_to_release = CaughtPokemon.find_by(name: pokepoke, trainer: $trainer1)
        poke_to_release.update(trainer: nil)
        puts "#{poke_to_release.name} has been released into the wild! They will miss you and all the adventures you've had together!"
        change_party_pokemon
    else
        change_party_pokemon
    end
end