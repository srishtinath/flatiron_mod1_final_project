require_relative '../config/environment.rb'
prompt = TTY::Prompt.new


def mistys_gym
    prompt = TTY::Prompt.new
    choice = prompt.select("What would you like to do?", ["Train my pokemon!", "Talk to Misty", "Go Back"])
        if choice == "Train my pokemon!"
            choose_pokemon_to_train
        elsif choice == "Talk to Misty"
            prompt.ok("She says hi")
            mistys_gym
        else
            explore
        end
    
end