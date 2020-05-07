require_relative '../config/environment.rb'


def starting_menu
    prompt = TTY::Prompt.new
    print TTY::Box.frame "Main Menu", align: :center
    action = prompt.select("What would you like to do?", ["Explore Town", "Catch Pokemon", "View My Pokemon", "View Pokedex", "Exit Game"])
    case action
    when "Explore Town"
        system "clear"
        explore
    when "Catch Pokemon"
        system "clear"
        catch_pokemon
    when "View My Pokemon"
        system "clear"
        view_all_pokemon
    when "View Pokedex"
        system "clear"
        poke_center
    else
        abort("Game ended!")
    end
end