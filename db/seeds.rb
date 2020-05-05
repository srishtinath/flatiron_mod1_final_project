require_relative '../pokeApi.rb'

Trainer.delete_all
CaughtPokemon.delete_all
Pokemon.delete_all
PokemonType.delete_all
Type.delete_all


initial_collect(20)

Trainer.create(name: "Kyle", age: 21)
Trainer.create(name: "Srishti", age: 21)
Trainer.create(name: "Don", age: 21)

CaughtPokemon.create(pokemon: Pokemon.first, trainer: Trainer.first)
CaughtPokemon.create(pokemon: Pokemon.first, trainer: Trainer.second)

