require_relative 'config/environment.rb'
require_all 'app/models'

def encounter_pokemon?

end

def random_pokemon_generator
    if encounter_pokemon?
        generate_number = rand(Pokemon.count)
        @pokemon_encounter = Pokemon.find(generate_number)
        puts "A Wild #{@pokemon_encounter.name} appeared!"
    else
        puts "Sorry, there are no pokemon here. Maybe try a different direction?"
    end
end

def attempt_catch
end

def pokemon_caught?
end