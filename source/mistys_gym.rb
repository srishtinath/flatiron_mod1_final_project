require_relative '../config/environment.rb'
prompt = TTY::Prompt.new


def mistys_gym
    prompt = TTY::Prompt.new
    print TTY::Box.frame "Misty's Gym", align: :center
    choice = prompt.select("What would you like to do?", ["Train my pokemon!", "Talk to Misty", "Go Back"])
        if choice == "Train my pokemon!"
            system "clear"
            choose_pokemon_to_train
        elsif choice == "Talk to Misty"
            print_pic('assets/mistytop.png')
            print TTY::Box.frame "Welcome to my gym #{$trainer1.name}! You can train your pokemon to be better here!", align: :center, title: {top_left: "Misty"}
            sleep(4)
            system "clear"
            mistys_gym
        else
            system "clear"
            explore
        end
    
end