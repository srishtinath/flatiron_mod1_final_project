require_relative 'config/environment.rb'


count = JSON.parse(RestClient.get("https://pokeapi.co/api/v2/pokemon"))["count"]
name = JSON.parse(RestClient.get("https://pokeapi.co/api/v2/pokemon/#{1}"))["name"]
type = JSON.parse(RestClient.get("https://pokeapi.co/api/v2/pokemon/#{1}"))["types"]
xp = JSON.parse(RestClient.get("https://pokeapi.co/api/v2/pokemon/#{1}"))["base_experience"]
level = 1
#151.times do |i|
    data = JSON.parse(RestClient.get("https://pokeapi.co/api/v2/pokemon#{1}"))
    Pokemon.create
#end


puts count
puts name
puts type.length
puts xp
