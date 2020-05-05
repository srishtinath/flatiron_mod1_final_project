require_relative 'config/environment.rb'
require 'pry'

##This file is used for filling Pokemon table
def initial_collect(num)
    num.times do |i|
        data = JSON.parse(RestClient.get("https://pokeapi.co/api/v2/pokemon/#{i+1}"))
        #count = data["count"]
        name = data["name"]
        xp = data["base_experience"]
        front_pic = data["sprites"]["front_default"]
        back_pic = data["sprites"]["back_default"]
        capture_rate = JSON.parse(RestClient.get(data["species"]["url"]))["capture_rate"]
<<<<<<< HEAD
        newPokemon = Pokemon.create(name:name,xp:xp,level:1,back_img_url:back_pic,front_img_url:front_pic,capture_rate:capture_rate)
=======
        # newPokemon.update(capture_rate: additional_data["capture_rate"])
        # newPokemon.save
>>>>>>> 0522be6a0b68daafa306ae62b607bd9c4e6aa8bc
        types = data["types"]
        types.length.times do |x|
            newType = types[x]["type"]["name"]
            typeExists = Type.find_by(name:"#{newType}")
            if(typeExists)
                newPokemon.types<<typeExists
            else
                newPokemon.types<<Type.create(name:"#{newType}")
            end
        end
    end
end