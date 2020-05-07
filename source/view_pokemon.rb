require_relative '../config/environment.rb'
prompt = TTY::Prompt.new


def party_pokemon(trainer)
    CaughtPokemon.where(trainer: trainer, party: true)
end

def non_party_pokemon(trainer)
    CaughtPokemon.where(trainer: trainer, party: false)
end

def view_all_pokemon
    prompt = TTY::Prompt.new
    print TTY::Box.frame "My Pokemon", align: :center
    action = prompt.select("What would you like to view?", ["View all pokemon", "View party pokemon", "View pokemon in storage", "Go Back"])
    if action == "View all pokemon"
        $trainer1.view_pokemon
        view_all_pokemon
    elsif action == "View party pokemon"
        $trainer1.view_party_pokemon
        view_all_pokemon
    elsif action == "View pokemon in storage"
        $trainer1.view_storage_pokemon
        view_all_pokemon
    else
        system "clear"
        catch_pokemon
    end
end
