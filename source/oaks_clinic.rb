require_relative '../config/environment.rb'
prompt = TTY::Prompt.new

def oaks_clinic #call the change party pokemon method in here
    ## add picture of oaks clinic
    prompt = TTY::Prompt.new
    prompt.say("Welcome to Professor Oak's clinic!")
    choice = prompt.select("What would you like to do?", ["Talk to Professor Oak", "Change my party pokemon", "Go Back"])
        if choice == "Talk to Professor Oak"
            ## add picture of Professor Oak
            text = "Hello #{$trainer1.name}! So kind of you to stop by! \nHave I told you about my grandson Gary? \nHe's officially caught a MILLION pokemon! \nJust kidding! \nGary is one of the best pokemon trainers out there though... \nyou could learn something from him!"
            print TTY::Box.frame text, align: :center, padding: 1, title: {top_left: "Professor Oak"}
            oaks_clinic
        elsif choice == "Change my party pokemon"
            change_party_pokemon
        else
            explore
        end

end