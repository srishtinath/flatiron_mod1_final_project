Trainer.delete_all
CaughtPokemon.delete_all

#These are commented so we dont have to keep pulling from pokeApi
# Pokemon.delete_all
# PokemonType.delete_all
# Type.delete_all



Trainer.create(name: "Kyle", age: 21)
Trainer.create(name: "Srishti", age: 21)
Trainer.create(name: "Don", age: 21)

CaughtPokemon.create(pokemon: Pokemon.first, trainer: Trainer.first)
CaughtPokemon.create(pokemon: Pokemon.first, trainer: Trainer.second)