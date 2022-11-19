require 'thor'
require 'pokemon'

module Pokedoc
  class CLI << thor
    def get(pokemon)
      puts Pokedoc::pokemon.get(pokemon)
    end
  end
end