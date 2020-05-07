require_relative '../config/environment.rb'

Trainer.delete_all
CaughtPokemon.delete_all
Pokemon.delete_all
PokemonType.delete_all
Type.delete_all


initial_collect(25)

kyle = Trainer.create(name: "Kyle", age: 21)
srishti = Trainer.create(name: "Srishti", age: 21)
don = Trainer.create(name: "Don", age: 21)

CaughtPokemon.create(pokemon: Pokemon.first, trainer: Trainer.first, name: "ABC")
CaughtPokemon.create(pokemon: Pokemon.first, trainer: Trainer.second, name: "DEF")
CaughtPokemon.create(pokemon: Pokemon.second, trainer: Trainer.second, name: "GHI")
CaughtPokemon.create(pokemon: Pokemon.second, trainer: Trainer.second, name: "JKL")
CaughtPokemon.create(pokemon: Pokemon.second, trainer: Trainer.second, name: "MNO")


p1 = CaughtPokemon.create(pokemon: Pokemon.first, trainer: don)
p2 = CaughtPokemon.create(pokemon: Pokemon.second, trainer: kyle)

