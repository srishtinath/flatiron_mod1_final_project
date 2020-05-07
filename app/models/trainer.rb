require_relative './../../source/pictures.rb'
class Trainer < ActiveRecord::Base
    has_many :caught_pokemons
    has_many :pokemons, through: :caught_pokemons
    
    attr_accessor :back_img_url
    def initialize(args)
        super
        self.update(back_img_url: 'https://i.imgur.com/YzPr8WH.png')
        
    end

    #View all pokemon belonging to trainer
    def view_pokemon
        array = CaughtPokemon.where(trainer: self)
        view_caught_pokemon(array)
        if array.count != 0
            array.each {|pokemon| puts "#{pokemon.poke_name}, (#{pokemon.pokemon.name.capitalize})"}
        else
            puts "You haven't caught any pokemon! Try catching some pokemon on your walk!"
        end
    end

    def view_party_pokemon
        array = CaughtPokemon.where(trainer: self, party:true)
        view_caught_pokemon(array)
        if array.count != 0
            array.each {|pokemon| puts "#{pokemon.poke_name}, (#{pokemon.pokemon.name.capitalize})"}
        else
            puts "You don't have any pokemon in your party!"
        end
    end

    def view_storage_pokemon
        array = CaughtPokemon.where(trainer: self, party:false)
        if array.count != 0
            view_caught_pokemon(array)
            array.each {|pokemon| puts "#{pokemon.poke_name}, (#{pokemon.pokemon.name.capitalize})"}
        else
            puts "You don't have any pokemon in storage!"
        end
    end


    def party_full?
        if !view_party_pokemon.empty?
            CaughtPokemon.where(trainer: self, party:true).size == 6 ? true : false
        else
            false
        end
    end

end