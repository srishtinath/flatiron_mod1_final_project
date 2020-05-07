require_relative '../config/environment.rb'


def starting_menu
    prompt = TTY::Prompt.new
    action = prompt.select("What would you like to do?", ["Explore Town", "Catch Pokemon", "View My Pokemon", "View Pokedex", "Exit Game"])
    case action
    when "Explore Town"
        explore
    when "Catch Pokemon"
        catch_pokemon
    when "View My Pokemon"
        view_all_pokemon
    when "View Pokedex"
        poke_center
    else
        abort("Game ended!")
    end

end