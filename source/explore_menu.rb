require_relative '../config/environment.rb'
prompt = TTY::Prompt.new


def explore
    prompt = TTY::Prompt.new
    location = prompt.select("Where would you like to go?", ["Professor Oak's Clinic", "Misty's Gym", "Brock's House", "Pokemon Center", "Police Station", "Go Back"])
    case location
    when "Brock's House"
        print TTY::Box.frame "Hey #{$trainer1.name}! Welcome to mi casa!!!", padding: 1, align: :center
        brocks_house
    when "Professor Oak's Clinic"
        oaks_clinic
    when "Pokemon Center"
        poke_center
    when "Police Station"
        print TTY::Box.warn("This is the police station. You don't want to end up in here!")
        explore
    when "Misty's Gym"
        mistys_gym
    else 
        starting_menu
    end
end