require_relative '../config/environment.rb'
prompt = TTY::Prompt.new


def poke_center #view all pokemons
    prompt = TTY::Prompt.new
    pokemons = Pokemon.all.map {|pokemon| pokemon.name}
    prompt.enum_select("Pokedex", pokemons, per_page: 6)
    ## re-add functionality for stats and xp
    explore
end