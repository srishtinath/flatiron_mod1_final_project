require_relative '../config/environment.rb'
prompt = TTY::Prompt.new

def change_party_pokemon
    prompt = TTY::Prompt.new
    print TTY::Box.frame "Change Party Pokemon", align: :center
    choice = prompt.select("What would you like to do?", ["Remove pokemon from party", "Add pokemon to party", "Change pokemon name", "Release pokemon to wild", "Go Back"])
        if choice == "Remove pokemon from party"
            remove_pokemon_from_party
        elsif choice == "Add pokemon to party"
            add_pokemon_to_party
        elsif choice == "Change pokemon name"
            change_pokemon_name
        elsif choice == "Release pokemon to wild"
            release_pokemon
        else
            system "clear"
            oaks_clinic
        end
end

def remove_pokemon_from_party
    prompt = TTY::Prompt.new
    party_array = party_pokemon($trainer1).map{|poke| poke.poke_name}
    if !party_array.empty?
        pokepoke = prompt.enum_select("Which pokemon would you like to remove from your party?", party_array, per_page: 5)
        #pokepoke = prompt.select("Which pokemon would you like to remove from your party?", party_array)
        chosen_one = CaughtPokemon.find_by(poke_name: pokepoke, trainer: $trainer1, party: true)
        chosen_one.update(party: false)
        print TTY::Box.success("#{chosen_one.poke_name} has been moved to storage!")
        #puts "#{chosen_one.poke_name} has been moved to storage!"
        sleep(1)
        system "clear"
        change_party_pokemon
    else
        print TTY::Box.error("You don't have any pokemon in your party!")
        #puts "You don't have any pokemon in your party!"
        sleep (1)
        system "clear"
        change_party_pokemon
    end
end


def add_pokemon_to_party
    prompt = TTY::Prompt.new
    non_party_array = non_party_pokemon($trainer1).map{|poke| poke.poke_name}
    party_array = party_pokemon($trainer1).map{|poke| poke.poke_name}
    if non_party_array.empty?
        print TTY::Box.error("You have no pokemon in storage to add to your party!")
        #puts "You have no pokemon in storage to add to your party!"
    elsif !party_array.empty? || party_array.size<6
        pokepoke = prompt.enum_select("Which pokemon would you like to add to your party?", non_party_array, per_page: 5)
        #pokepoke = prompt.select("Which pokemon would you like to add to your party?", non_party_array)
        chosen_one = CaughtPokemon.find_by(poke_name: pokepoke, trainer: $trainer1, party: false)
        chosen_one.update(party: true)
        print TTY::Box.success("#{chosen_one.poke_name} has been added to your party!")
    else
        print TTY::Box.error("Your party is full. Please move some to storage first.")
    end
    sleep(2)
    system "clear"
    change_party_pokemon
end




def change_pokemon_name
    prompt = TTY::Prompt.new
    party_array = CaughtPokemon.where(trainer:$trainer1).map{|poke| poke.poke_name}
    pokepoke = prompt.enum_select("Which pokemon's name would you like to change?", party_array, per_page: 5)
    #pokepoke = prompt.select("Which pokemon's name would you like to change?", party_array)
    new_name = prompt.ask("What would you like to change it to?")
    poke_to_change = CaughtPokemon.find_by(poke_name: pokepoke, trainer: $trainer1)
    poke_to_change.update(poke_name: new_name)
    print TTY::Box.success("Your pokemon's name has been changed to #{poke_to_change.poke_name}!")
    sleep(2)
    system "clear"
    change_party_pokemon
end

def release_pokemon
    prompt = TTY::Prompt.new
    party_array = CaughtPokemon.where(trainer:$trainer1).map{|poke| poke.poke_name}
    if party_array.empty?
        print TTY::Box.error("You don't have any pokemon!")
        sleep(1)
        system "clear"
        oaks_clinic
    else
        pokepoke = prompt.enum_select("Which pokemon would you like to release into the wild unknown?", party_array, per_page: 5)
        #pokepoke = prompt.select("Which pokemon would you like to release into the wild unknown?", party_array)
        sure = prompt.yes?("Are you sure you want to release #{pokepoke}?")
        if sure
            poke_to_release = CaughtPokemon.find_by(poke_name: pokepoke, trainer: $trainer1)
            poke_to_release.update(trainer: nil)
            print TTY::Box.success("#{poke_to_release.poke_name} has been released into the wild! They will miss you and all the adventures you've had together!")
            sleep(2)
            system "clear"
            change_party_pokemon
        else
            system "clear"
            change_party_pokemon
        end
    end
end