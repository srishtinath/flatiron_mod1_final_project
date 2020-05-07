require_relative '../config/environment.rb'
prompt = TTY::Prompt.new

def brocks_house
    ### add picture of brocks house / brock
    prompt = TTY::Prompt.new
    prompt.ok("Hey #{$trainer1.name}!!!")
    prompt.ok("Welcome to mi casa}!!!")
    choice = prompt.select("What can I do for you", ["Game Instructions", "Chit Chat", "Leave"])
    case choice
    when "Game Instructions"
        puts "Game Instructions:"
        puts "Party Pokemon"
        puts "How to Catch a Pokemon"
    when "Chit Chat"
        puts "lets chitty chat"
    else
        explore
    end
end