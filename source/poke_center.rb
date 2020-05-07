require_relative '../config/environment.rb'
prompt = TTY::Prompt.new

###Kyle - add pokemon image in this file
def poke_center #view all pokemons
    system "clear"
    print TTY::Box.frame "Pokemon Center", align: :center
    prompt = TTY::Prompt.new
    pokemons = Pokemon.all.map {|pokemon| pokemon.name.capitalize}
    choice = prompt.enum_select("Pokedex", pokemons, per_page: 5)
    poke = Pokemon.find_by(name: choice.downcase)
    poketypes = PokemonType.find_by(id: poke.id)
    actual_types = Type.find_by(id: poketypes.type_id)
    #puts actual_types.name

    print TTY::Box.frame "Type: #{actual_types.name}", "XP: #{poke.xp}", "Capture Rate: #{poke.capture_rate}", align: :center, padding: 1, title: {top_left: "#{poke.name.capitalize}"}
    choice = prompt.yes?("Would you like to view more pokemon?")
    if choice 
        poke_center
    else
        system "clear"
        explore
    end
end