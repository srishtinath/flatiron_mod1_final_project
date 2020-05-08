# file for CLI commands
require_relative 'config/environment.rb'


def play_game
    prompt = TTY::Prompt.new
    font = TTY::Font.new(:doom)
    pastel = Pastel.new
    system "clear"
    print_pic("assets/poketerm_logo.png")
    puts pastel.red.bold.italic(font.write("Welcome  to  Safari  Zone  !", letter_spacing: 2))
    prompt.keypress("Press enter to continue", keys: [:return])
    begin_game
end

def begin_game
    prompt = TTY::Prompt.new
    choice = prompt.select("", ["Start a new game!", "Continue your game!", "Exit"], active_color: :cyan)
    case choice
    when "Start a new game!"
        system "clear"
        trainer_creation
        choose_starter
    when "Continue your game!"
        system "clear"
        find_my_trainer
    else
        abort("Game Exited")
    end
end

play_game
