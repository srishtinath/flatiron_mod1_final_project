# file for CLI commands
require_relative 'config/environment.rb'

prompt = TTY::Prompt.new


def play_game
    prompt = TTY::Prompt.new
    system "clear"
    print_pic("assets/poketerm_logo.png")
    prompt.say("Welcome to Pokemon World!!!")
    prompt.keypress("Press enter to continue", keys: [:return])
    begin_game
end

def begin_game
    prompt = TTY::Prompt.new
    choice = prompt.select("", ["Start a new game!", "Continue your game!", "Exit"], active_color: :cyan)
    case choice
    when "Start a new game!"
        trainer_creation
        choose_starter
    when "Continue your game!"
        find_my_trainer
    else
        abort("Game Exited")
    end
end

play_game
