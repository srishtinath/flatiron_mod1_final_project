require_relative '../config/environment.rb'
prompt = TTY::Prompt.new

def win_game
    prompt = TTY::Prompt.new
    print TTY::Box.success("CONGRATULATIONS! \nYou have caught 10 pokemon! \nYou have won the Pokemon Safari Zone! \nWith your new pokemon, you're good and ready to take on your first gym battle! \n(...coming soon)")
    puts "Game won!"
end