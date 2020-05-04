Pokemon.delete_all
Trainer.delete_all
CaughtPokemon.delete_all

Trainer.create(name: "Kyle", age: 21)
Trainer.create(name: "Srishti", age: 21)

Pokemon.create(name: "Pikachu")
Pokemon.create(name: "Charmander")
Pokemon.create(name: "Bulbasaur")

CaughtPokemon.create(pokemon: Pokemon.first, trainer: Trainer.first)
CaughtPokemon.create(pokemon: Pokemon.first, trainer: Trainer.second)