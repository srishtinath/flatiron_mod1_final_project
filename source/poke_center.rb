require_relative '../config/environment.rb'
prompt = TTY::Prompt.new

def poke_center #view all pokemons
    prompt = TTY::Prompt.new
    pokemons = Pokemon.all.map {|pokemon| pokemon.name.capitalize}
    choice = prompt.enum_select("Pokedex", pokemons, per_page: 5)
    poke = Pokemon.find_by(name: choice.downcase)
    poketypes = poke.types
    # actual_types = Type.find_by(id: poketypes.type_id)
    #puts actual_types.name
    system "clear"
    display_one(poke)
    typeStr = ''
    poketypes.length.times do |i|
        typeStr+="#{poketypes[i].name}"
        if(i!=poketypes.length-1)
            typeStr+=", "
        end
    end
    print TTY::Box.frame "Type: #{typeStr}", "XP: #{poke.xp}", "Capture Rate: #{poke.capture_rate}", align: :center, padding: 1, title: {top_left: "#{poke.name.capitalize}"}
    choice = prompt.yes?("Would you like to view more pokemon?")
    choice ? poke_center : explore
end