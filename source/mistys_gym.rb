require_relative '../config/environment.rb'
prompt = TTY::Prompt.new


def mistys_gym
    prompt = TTY::Prompt.new
    choice = prompt.select("What would you like to do?", ["Train my pokemon!", "Talk to Misty", "Go Back"])
        if choice == "Train my pokemon!"
            choose_pokemon_to_train
        elsif choice == "Talk to Misty"
            prompt.ok("Welcome to my gym #{$trainer1.name}! You can train your pokemon to be better here!")
            mistys_gym
        else
            explore
        end
    
end