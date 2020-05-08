require_relative '../config/environment.rb'

Trainer.delete_all
CaughtPokemon.delete_all
Pokemon.delete_all
PokemonType.delete_all
Type.delete_all


initial_collect(151)

kyle = Trainer.create(name: "Kyle", age: 21)
srishti = Trainer.create(name: "Srishti", age: 21)
don = Trainer.create(name: "Don", age: 21)

CaughtPokemon.create(pokemon: Pokemon.first, trainer: Trainer.first, poke_name: "ABC")
CaughtPokemon.create(pokemon: Pokemon.first, trainer: Trainer.second, poke_name: "DEF")
CaughtPokemon.create(pokemon: Pokemon.second, trainer: Trainer.second, poke_name: "GHI")
CaughtPokemon.create(pokemon: Pokemon.second, trainer: Trainer.second, poke_name: "JKL")
CaughtPokemon.create(pokemon: Pokemon.second, trainer: Trainer.second, poke_name: "MNO")


p1 = CaughtPokemon.create(pokemon: Pokemon.first, trainer: don)
p2 = CaughtPokemon.create(pokemon: Pokemon.second, trainer: kyle)

