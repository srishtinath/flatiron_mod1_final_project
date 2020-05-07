require_relative '../config/environment.rb'
prompt = TTY::Prompt.new


def explore
    prompt = TTY::Prompt.new
    location = prompt.select("Where would you like to go?", ["Professor Oak's Clinic", "Misty's Gym", "Brock's House", "Pokemon Center", "Police Station", "Go Back"])
    case location
    when "Brock's House"
        system "clear"
        print_pic('assets/house.png')
        print TTY::Box.frame "Hey #{$trainer1.name}! Welcome to mi casa!!!", padding: 1, align: :center
        brocks_house
    when "Professor Oak's Clinic"
        system "clear"
        print_pic('assets/oaks.png')
        oaks_clinic
    when "Pokemon Center"
        system "clear"
        print_pic('assets/pokecenter.png')
        poke_center
    when "Police Station"
        system "clear"
        print_pic('assets/house.png')
        print TTY::Box.warn("This is the police station. You don't want to end up in here!")
        explore
    when "Misty's Gym"
        system "clear"
        print_pic('assets/mistysgym.png')
        mistys_gym
    else 
        starting_menu
    end
end