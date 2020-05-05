require_relative 'config/environment.rb'

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
        newPokemon = Pokemon.create(name:name,xp:xp,level:1,back_img_url:back_pic,front_img_url:front_pic,capture_rate:capture_rate)
        
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


