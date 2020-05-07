require_relative '../config/environment.rb'
prompt = TTY::Prompt.new

def oaks_clinic #call the change party pokemon method in here
    ## add picture of oaks clinic
    prompt = TTY::Prompt.new
    print TTY::Box.frame "Professor Oak's clinic!", align: :center
    choice = prompt.select("What would you like to do?", ["Talk to Professor Oak", "Change my party pokemon", "Go Back"])
        if choice == "Talk to Professor Oak"
            text = "Hello #{$trainer1.name}! So kind of you to stop by! \nHave I told you about my grandson Gary? \nHe's officially caught a MILLION pokemon! \nJust kidding! \nGary is one of the best pokemon trainers out there though... \nyou could learn something from him!"
            print_pic('assets/oaktop.png')
            print TTY::Box.frame text, align: :center, padding: 1, title: {top_left: "Professor Oak"}
            sleep(6)
            system "clear"
            oaks_clinic
        elsif choice == "Change my party pokemon"
            system "clear"
            change_party_pokemon
        else
            system "clear"
            explore
        end

end