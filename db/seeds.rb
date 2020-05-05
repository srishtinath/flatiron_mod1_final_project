require_relative '../pokeApi.rb'

# Pokemon.delete_all
Trainer.delete_all
CaughtPokemon.delete_all

Trainer.create(name: "Kyle", age: 21)
Trainer.create(name: "Srishti", age: 21)
Trainer.create(name: "Don", age: 21)

CaughtPokemon.create(pokemon: Pokemon.first, trainer: Trainer.first)
CaughtPokemon.create(pokemon: Pokemon.first, trainer: Trainer.second)

