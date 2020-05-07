require_relative '../config/environment.rb'
prompt = TTY::Prompt.new


def explore
    prompt = TTY::Prompt.new
    print TTY::Box.frame "Explore", align: :center
    location = prompt.select("Where would you like to go?", ["Professor Oak's Clinic", "Misty's Gym", "Brock's House", "Pokemon Center", "Police Station", "Go Back"])
    case location
    when "Brock's House"
        system "clear"
        print_pic('assets/house.png')
        sleep(1)
        system "clear"
        brocks_house
    when "Professor Oak's Clinic"
        system "clear"
        print_pic('assets/oaks.png')
        sleep(1)
        system "clear"
        oaks_clinic
    when "Pokemon Center"
        system "clear"
        print_pic('assets/pokecenter.png')
        sleep(1)
        system "clear"
        poke_center
    when "Police Station"
        system "clear"
        print_pic('assets/house.png')
        print TTY::Box.warn("This is the police station. You don't want to end up in here!")
        sleep(2)
        system "clear"
        explore
    when "Misty's Gym"
        system "clear"
        print_pic('assets/mistysgym.png')
        sleep(1)
        system "clear"
        mistys_gym
    else 
        system "clear"
        starting_menu
    end
end