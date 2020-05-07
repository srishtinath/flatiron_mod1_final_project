require_relative '../config/environment.rb'
prompt = TTY::Prompt.new


#instructions = TTY::Box.frame(width: 20, height: 10)

def brocks_house
    ### add picture of brocks house / brock
    prompt = TTY::Prompt.new
     choice = prompt.select("What can I do for you?", ["Game Instructions", "Chit Chat", "Leave"])
    case choice
    when "Game Instructions"
        print TTY::Box.frame "GAME INSTRUCTIONS", "1. You can explore the city via the main menu.", "2. You can learn about all the pokemon by visiting the Poke Center.", "3. To succesfully catch a pokemon, feed and compliment the pokemon.", "4. You can only have 6 pokemon in your party. Visit Professor Oak to make changes.", "5. Visit Misty's gym too train and level up your pokemon.", padding: 1, align: :left
        #print box
        brocks_house
    when "Chit Chat"
        puts "lets chitty chat"
        brocks_house
    else
        explore
    end
end