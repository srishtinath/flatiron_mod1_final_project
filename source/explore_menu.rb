require_relative '../config/environment.rb'
prompt = TTY::Prompt.new


def explore
    prompt = TTY::Prompt.new
    location = prompt.select("Where would you like to go?", ["Professor Oak's Clinic", "Misty's Gym", "Brock's House", "Pokemon Center", "Police Station", "Go Back"])
    case location
    when "Brock's House"
        brocks_house
    when "Professor Oak's Clinic"
        oaks_clinic
    when "Pokemon Center"
        poke_center
        explore
    when "Police Station"
        prompt.warn("This is the Police station. You don't want to end up in here!")
    when "Misty's Gym"
        mistys_gym
    else 
        starting_menu
    end  
end