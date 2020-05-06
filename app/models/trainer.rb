class Trainer < ActiveRecord::Base
    has_many :caught_pokemons
    has_many :pokemons, through: :caught_pokemons
    attr_accessor :back_img_url
    def initialize(args)
        super
        self.update(back_img_url: 'https://i.imgur.com/YzPr8WH.png')
        
    end
    

    def change_pokemon_name(pokemon, name)
        poke = CaughtPokemon.find_by(id: pokemon.id, trainer: self)
        poke.update(name: name)
        puts "Your pokemon's name has been updated to #{name}!"
    end

    #View all pokemon belonging to trainer
    def view_pokemon
        array = CaughtPokemon.where(trainer: self)
        if array.count != 0
            array.each {|pokemon| puts "#{pokemon.name}, (#{pokemon.pokemon.name.capitalize})"}
        else
            puts "You haven't caught any pokemon! Try catching some pokemon on your walk!"
        end
    end

    def view_party_pokemon
        array = CaughtPokemon.where(trainer: self, party:true)
        if array.count != 0
            array.each {|pokemon| puts "#{pokemon.name}, (#{pokemon.pokemon.name.capitalize})"}
        else
            puts "You don't have any pokemon in your party!"
        end
    end

    def view_storage_pokemon
        array = CaughtPokemon.where(trainer: self, party:false)
        if array.count != 0
            array.each {|pokemon| puts "#{pokemon.name}, (#{pokemon.pokemon.name.capitalize})"}
        else
            puts "You don't have any pokemon in storage!"
        end
    end

    def remove_pokemon_from_party(pokemon)
        poke = CaughtPokemon.find_by(pokemon: pokemon, trainer: self)
        poke.update(party:false)
        left_in_party = 6 - view_party_pokemon.count
        puts "You now have #{left_in_party} spots left in your party!"
    end

    def party_full?
        view_party_pokemon.count == 6 ? true : false
    end

    def add_pokemon_to_party(pokemon)
        if party_full?
            puts "You cannot have more than 6 pokemon in your party. First move some to Professor Oak's clinic before adding Pokemon to your party."
        else
            pokemon.update(party:true)
            puts "You have now added #{pokemon.name} to your party!"
        end
    end

    def move_pokemon_to_storage(pokemon)
        pokemon.party = false
        puts "You have now put #{pokemon.name} in storage!"
    end

    #train pokemon
    def train(pokemon)
        poke = CaughtPokemon.find_by(pokemon.id)
        poke.update(level += 1)
        poke.save
    end
    
    #release into wild
    def release(pokemon)
        poke = CaughtPokemon.find_by(pokemon.id)
        poke.update(trainer_id: nil)
    end

end