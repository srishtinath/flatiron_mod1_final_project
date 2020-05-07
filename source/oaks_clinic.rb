require_relative '../config/environment.rb'
prompt = TTY::Prompt.new


def oaks_clinic #call the change party pokemon method in here
    ## add picture of oaks clinic
    prompt = TTY::Prompt.new
    prompt.say("Welcome to Professor Oak's clinic!")
    choice = prompt.select("What would you like to do?", ["Talk to Professor Oak", "Change my party pokemon", "Go Back"])
        if choice == "Talk to Professor Oak"
            ## add picture of Professor Oak
            puts "Hello #{$trainer1.name}! So kind of you to stop by! Have I told you about my grandson Gary?"
            puts "He's caught a MILLION pokemon!"
            puts "Just kidding! Gary is one of the best pokemon trainers out there though... you could learn something from him!"
            oaks_clinic
        elsif choice == "Change my party pokemon"
            change_party_pokemon
        else
            explore
        end

end