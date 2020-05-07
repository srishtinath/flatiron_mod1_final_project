require_relative '../config/environment.rb'
prompt = TTY::Prompt.new

def win_game
    prompt = TTY::Prompt.new
    print TY::Box.success("CONGRATULATIONS!", "You have caught 10 pokemon!", "You have won the Pokemon Safari Zone!", "With your new pokemon, you're good and ready to take on your first gym battle!", "(...coming soon)")
    abort("Game won!")
end